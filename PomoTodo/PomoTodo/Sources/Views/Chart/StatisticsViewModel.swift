//
//  StatisticsViewModel.swift
//  PomoTodo
//
//  Created by 도민준 on 2/18/25.
//

import Foundation

// 통계 뷰 모델
@Observable
final class StatisticsViewModel {
  enum SelectedPeriod {
    case day
    case week
    case month
  }
  
  // 연도와 주를 포함하는 구조체 (Hashable 준수)
  private struct YearWeek: Hashable {
    let year: Int
    let week: Int
  }

  // 연도와 월을 포함하는 구조체 (Hashable 준수)
  private struct YearMonth: Hashable {
    let year: Int
    let month: Int
  }
  
  struct State {
    var selectedPeriod: SelectedPeriod = .day
    var displayDate: String = ""
    
    // MARK: UI에 표시할 통계 Property
    var totalPomodoro: Int = 0
    var totalSessions: Double = 0
    var totalFocusTime: TimeInterval = 0
    var allFocusTime: TimeInterval = 0
    var allSessions: Double = 0
    var averageFocusTime: TimeInterval = 0
    var averageSessions: Double = 0
    var tagFocusData: [TagTimeRecord] = []
  }
  
  // MARK: UI에서 사용하는 Methods
  enum Action {
    case updatePeriod(SelectedPeriod)  // 일간, 주간, 월간 변경
    case previousDate  // 이전 날짜로 이동
    case nextDate  // 다음 날짜로 이동
    case loadData  // 데이터 로드
  }
  
  private(set) var state: State = .init()
  private let pomoTodoUseCase: PomoTodoUseCase
  private let calendar = Calendar.current
  private var currentDate = Date()
  private var pomoDayData: [PomoDay] = []
  
  init(pomoTodoUseCase: PomoTodoUseCase) {
    self.pomoTodoUseCase = pomoTodoUseCase
    send(.loadData)
  }
  
  func send(_ action: Action) {
    switch action {
    case .updatePeriod(let period):
      state.selectedPeriod = period
      updateData()
      
    case .previousDate:
      guard let previousDate = getPreviousAvailableDate() else { return }
      currentDate = previousDate
      updateData()
      
    case .nextDate:
      guard let nextDate = getNextAvailableDate() else { return }
      currentDate = nextDate
      updateData()
      
    case .loadData:
      pomoDayData = pomoTodoUseCase.getAllPomoDays()
      updateData()
    }
  }
  
  //  // 태그 정보 (이제 뷰모델에서 관리)
  //  let fixedTags: [Tag] = [
  //    Tag(id: "1", index: 1, name: "공부", colorId: 1),
  //    Tag(id: "2", index: 2, name: "운동", colorId: 2),
  //    Tag(id: "3", index: 3, name: "독서", colorId: 3),
  //    Tag(id: "4", index: 4, name: "취미", colorId: 4)
  //  ]
  
  
  
  // 데이터 필터링 후 업데이트
  func updateData() {
    let filteredData = filterData(for: state.selectedPeriod)
    
    state.totalPomodoro = filteredData.reduce(0) { $0 + $1.tomatoCnt }
    state.totalSessions = filteredData.reduce(0) { $0 + $1.cycleCnt }
    state.totalFocusTime = filteredData.reduce(0) { $0 + $1.totalTime }
    
    // 전체 누적된 데이터 기준으로 총 집중시간과 세션 계산
    state.allFocusTime = pomoDayData.reduce(0) { $0 + $1.totalTime }
    state.allSessions = pomoDayData.reduce(0) { $0 + $1.cycleCnt }
    
    // 사용한 일/주/월 수 가져오기 (실제 데이터 존재하는 기간 기준)
    let (usedDays, usedWeeks, usedMonths) = getUsedPeriods()
    
    // 일/주/월간 "평균" 계산
    state.averageFocusTime = state.allFocusTime / Double(max(1, usedDays))
    state.averageSessions = state.allSessions / Double(max(1, usedDays))
    
    switch state.selectedPeriod {
    case .week:
      state.averageFocusTime = state.allFocusTime / Double(max(1, usedWeeks))
      state.averageSessions = state.allSessions / Double(max(1, usedWeeks))
    case .month:
      state.averageFocusTime = state.allFocusTime / Double(max(1, usedMonths))
      state.averageSessions = state.allSessions / Double(max(1, usedMonths))
    case .day:
      break  // 기본적으로 days로 계산됨
    }
    
    //    print("사용한 총 일수: \(usedDays), 주 수: \(usedWeeks), 월 수: \(usedMonths)")
    //    print("평균 집중 시간 (일간 기준): \(averageFocusTime.formattedTime())")
    //    print("평균 세션 (일간 기준): \(averageSessions)")
    
    // 태그별 집중시간 데이터 정렬
    //    tagFocusData = aggregateTagFocusTime(from: filteredData)
    //    tagFocusData.sort { (tag1, tag2) in
    //      let index1 = fixedTags.first { $0.id == tag1.tagId }?.index ?? Int.max
    //      let index2 = fixedTags.first { $0.id == tag2.tagId }?.index ?? Int.max
    //      return index1 < index2
    //    }
    state.tagFocusData = aggregateTagFocusTime(from: filteredData)
    updateDisplayDate()
  }
  
  // 실제 사용한 "주"와 "월" 개수 반환
  private func getUsedPeriods() -> (days: Int, weeks: Int, months: Int) {
    let usedDays = Set(pomoDayData.map { calendar.startOfDay(for: $0.date) })
    
    // 연도 + 주를 묶어서 Set에 저장
    let usedWeeks = Set(pomoDayData.map {
      YearWeek(year: calendar.component(.year, from: $0.date),
               week: calendar.component(.weekOfYear, from: $0.date))
    })
    
    // 연도 + 월을 묶어서 Set에 저장
    let usedMonths = Set(pomoDayData.map {
      YearMonth(year: calendar.component(.year, from: $0.date),
                month: calendar.component(.month, from: $0.date))
    })
    
    return (usedDays.count, usedWeeks.count, usedMonths.count)
  }
  
  
  // 태그별 집중시간 계산
  private func aggregateTagFocusTime(from pomoDays: [PomoDay]) -> [TagTimeRecord] {
    var tagMap: [String: TimeInterval] = [:]
    for day in pomoDays {
      for record in day.tagTimeRecords {
        tagMap[record.tagId, default: 0] += record.focusTime
      }
    }
    return tagMap.map { TagTimeRecord(tagId: $0.key, focusTime: $0.value) }
  }
  
  // 날짜 필터링 함수
  private func filterData(for period: SelectedPeriod) -> [PomoDay] {
    return pomoDayData.filter { day in
      switch period {
      case .day:
        return calendar.isDate(day.date, inSameDayAs: currentDate)
      case .week:
        guard let weekStart = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start else { return false }
        guard let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart) else { return false }
        return day.date >= weekStart && day.date <= weekEnd
      case .month:
        return calendar.isDate(day.date, equalTo: currentDate, toGranularity: .month)
      }
    }
  }
  
  // 날짜 업데이트 함수 (주간 & 월간 날짜 표시 수정)
  private func updateDisplayDate() {
    let dateFormatter = DateFormatter()
    
    switch state.selectedPeriod {
    case .day:
      dateFormatter.dateFormat = "YYYY년 M월 d일"
      state.displayDate = dateFormatter.string(from: currentDate)
      
    case .week:
      guard let weekStart = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start else { return }
      guard let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart) else { return }
      dateFormatter.dateFormat = "M월 d일"
      state.displayDate = "\(dateFormatter.string(from: weekStart)) - \(dateFormatter.string(from: weekEnd))"
      
    case .month:
      dateFormatter.dateFormat = "YYYY년 M월"
      state.displayDate = dateFormatter.string(from: currentDate)
    }
  }
  
  // 날짜 이동 (저장된 데이터가 있는 날짜만 이동)
//  func previousDate() {
//    guard let previousDate = getPreviousAvailableDate() else { return }
//    currentDate = previousDate
//    updateData()
//  }
//  
//  func nextDate() {
//    guard let nextDate = getNextAvailableDate() else { return }
//    currentDate = nextDate
//    updateData()
//  }
  
  // MARK: 아래 메서드 레포지토리랑 병합 고려
  // 이전 날짜
  func getPreviousAvailableDate() -> Date? {
    let sortedDates = pomoDayData.map { $0.date }.sorted(by: >) // 최신순 정렬
    
    switch state.selectedPeriod {
    case .day:
      return sortedDates.first(where: { $0 < currentDate }) // 가장 가까운 과거 날짜
      
    case .week:
      let currentWeek = calendar.component(.weekOfYear, from: currentDate)
      let currentYear = calendar.component(.year, from: currentDate)
      
      return sortedDates.first(where: { date in
        let week = calendar.component(.weekOfYear, from: date)
        let year = calendar.component(.year, from: date)
        return year < currentYear || (year == currentYear && week < currentWeek)
      })
      
    case .month:
      let currentYearMonth = (calendar.component(.year, from: currentDate) * 100) + calendar.component(.month, from: currentDate)
      
      return sortedDates.first(where: { date in
        let yearMonth = (calendar.component(.year, from: date) * 100) + calendar.component(.month, from: date)
        return yearMonth < currentYearMonth // 현재 연월보다 작은 가장 가까운 데이터 찾기
      })
    }
  }
  
  // 다음 날짜
  func getNextAvailableDate() -> Date? {
    let sortedDates = pomoDayData.map { $0.date }.sorted(by: <) // 과거순 정렬
    
    switch state.selectedPeriod {
    case .day:
      return sortedDates.first(where: { $0 > currentDate }) // 가장 가까운 미래 날짜
      
    case .week:
      let currentWeek = calendar.component(.weekOfYear, from: currentDate)
      let currentYear = calendar.component(.year, from: currentDate)
      
      return sortedDates.first(where: { date in
        let week = calendar.component(.weekOfYear, from: date)
        let year = calendar.component(.year, from: date)
        return year > currentYear || (year == currentYear && week > currentWeek)
      })
      
    case .month:
      let currentYearMonth = (calendar.component(.year, from: currentDate) * 100) + calendar.component(.month, from: currentDate)
      
      return sortedDates.first(where: { date in
        let yearMonth = (calendar.component(.year, from: date) * 100) + calendar.component(.month, from: date)
        return yearMonth > currentYearMonth // 현재 연월보다 큰 가장 가까운 데이터 찾기
      })
    }
  }
}
