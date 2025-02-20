//
//  StatisticsViewModel.swift
//  PomoTodo
//
//  Created by 도민준 on 2/18/25.
//

import SwiftUI

// 통계 뷰 모델
class StatisticsViewModel: ObservableObject {
  
  // MARK: - UI 변수
  @Published var selectedPeriod: String = "일"
  @Published var displayDate: String = ""
  @Published var totalPomodoro: Int = 0
  @Published var totalSessions: Double = 0
  @Published var totalFocusTime: TimeInterval = 0
  @Published var allFocusTime: TimeInterval = 0
  @Published var allSessions: Double = 0
  @Published var averageFocusTime: TimeInterval = 0
  @Published var averageSessions: Double = 0
  @Published var tagFocusData: [TagTimeRecord] = []
  
  // 버튼 활성화 상태
  @Published var isPreviousAvailable: Bool = false
  @Published var isNextAvailable: Bool = false
  
  // MARK: - Action Case 정의
  enum Action {
    case onAppear
    case changePeriod(String)
    case previousDate
    case nextDate
    case updateDataManual
  }
  
  // MARK: - Private 변수
  private let calendar = Calendar.current
  private var currentDate = Date()
  private var pomoDayData: [PomoDay] = []
  
  private let pomoTodoUseCase: PomoTodoUseCase
  
  // MARK: - 생성자
  init(pomoTodoUseCase: PomoTodoUseCase) {
    self.pomoTodoUseCase = pomoTodoUseCase
    //loadPomoData()
  }
  
  // MARK: - Action 구현
  func send(_ action: Action) {
    switch action {
    case .onAppear:
      loadData()
      
    case .changePeriod(let period):
      selectedPeriod = period
      updateData()
      
    case .previousDate:
      previousDate()
      
    case .nextDate:
      nextDate()
      
    case .updateDataManual:
      updateData()
    }
  }
}

extension StatisticsViewModel {
  
  // MARK: - Private 함수
  /// 뷰가 처음 나타날 때 데이터 불러오기
  private func loadData() {
    // 전체 PomoDay 데이터 불러오기
    pomoDayData = pomoTodoUseCase.getAllPomoDays()
    
    // 가장 최신 날짜로 설정
    if let latestDate = pomoDayData.map({ $0.date }).max() {
      currentDate = latestDate
    }
    
    updateData()
    
    updateButtonStates()
  }
  
  /// 현재 상태(선택된 기간 등)에 맞춰 데이터를 업데이트하는 메서드
  private func updateData() {
    // 현재 기간에 맞게 필터링된 데이터
    let filteredData = filterData(for: selectedPeriod)
    
    // 총 포모도로 수, 총 세션 수, 총 집중시간
    totalPomodoro = filteredData.reduce(0) { $0 + $1.tomatoCnt }
    totalSessions = filteredData.reduce(0) { $0 + $1.cycleCnt }
    totalFocusTime = filteredData.reduce(0) { $0 + $1.totalTime }
    
    // 모든 데이터 기준(전체 기간) 누적된 집중시간, 세션
    allFocusTime = pomoDayData.reduce(0) { $0 + $1.totalTime }
    allSessions = pomoDayData.reduce(0) { $0 + $1.cycleCnt }
    
    // 실제 사용된 일/주/월의 수
    let (usedDays, usedWeeks, usedMonths) = getUsedPeriods()
    
    // 평균값 계산 (기본: 일 단위)
    averageFocusTime = allFocusTime / Double(max(1, usedDays))
    averageSessions = allSessions / Double(max(1, usedDays))
    
    // 주/월 선택 시 기준 변경
    if selectedPeriod == "주" {
      averageFocusTime = allFocusTime / Double(max(1, usedWeeks))
      averageSessions = allSessions / Double(max(1, usedWeeks))
    } else if selectedPeriod == "월" {
      averageFocusTime = allFocusTime / Double(max(1, usedMonths))
      averageSessions = allSessions / Double(max(1, usedMonths))
    }
    
    // 태그별 집중시간
    tagFocusData = aggregateTagFocusTime(from: filteredData)
    // 태그 순서 정렬 (AppConfig의 tag 배열 index 순)
    sortTagFocusData()
    
    // 화면에 표시할 날짜 문자열 업데이트
    updateDisplayDate()
    
    // 버튼 활성화 상태 갱신
    updateButtonStates()
  }
  
  
  // 실제 사용된 일/주/월 개수 계산
  private func getUsedPeriods() -> (days: Int, weeks: Int, months: Int) {
    // 날짜(일) Set
    let usedDays = Set(pomoDayData.map {
      calendar.startOfDay(for: $0.date)
    })
    
    // 주(연도+주) Set
    let usedWeeks = Set(pomoDayData.map {
      YearWeek(
        year: calendar.component(.year, from: $0.date),
        week: calendar.component(.weekOfYear, from: $0.date)
      )
    })
    
    // 월(연도+월) Set
    let usedMonths = Set(pomoDayData.map {
      YearMonth(
        year: calendar.component(.year, from: $0.date),
        month: calendar.component(.month, from: $0.date)
      )
    })
    
    return (usedDays.count, usedWeeks.count, usedMonths.count)
  }
  
  // 화면에 표시할 날짜 문자열 업데이트
  private func updateDisplayDate() {
    let dateFormatter = DateFormatter()
    
    switch selectedPeriod {
    case "일":
      dateFormatter.dateFormat = "yyyy년 M월 d일"
      displayDate = dateFormatter.string(from: currentDate)
      
    case "주":
      // 주간 범위 (ex: 2/19 ~ 2/25)
      guard let weekStart = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start,
            let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart) else {
        return
      }
      dateFormatter.dateFormat = "M월 d일"
      displayDate = "\(dateFormatter.string(from: weekStart)) - \(dateFormatter.string(from: weekEnd))"
      
    case "월":
      dateFormatter.dateFormat = "yyyy년 M월"
      displayDate = dateFormatter.string(from: currentDate)
      
    default:
      break
    }
  }
  
  // 버튼 활성화 상태 업데이트 함수 추가
  private func updateButtonStates() {
    isPreviousAvailable = getPreviousAvailableDate() != nil
    isNextAvailable = getNextAvailableDate() != nil
  }
  
  // 이전 날짜로 이동
  private func previousDate() {
    guard let previousDate = getPreviousAvailableDate() else { return }
    currentDate = previousDate
    updateData()
  }
  
  // 다음 날짜로 이동
  private func nextDate() {
    guard let nextDate = getNextAvailableDate() else { return }
    currentDate = nextDate
    updateData()
  }
  
  // MARK: - 이거 레포지토리로 이동해도 되긴하는데 통계뷰말고 쓰이는데가 있나 싶어서 보고 판단하셔야 할 것 같습니다.
  // 기간에 맞게 데이터 필터링
  private func filterData(for period: String) -> [PomoDay] {
    pomoDayData.filter { day in
      switch period {
      case "일":
        return calendar.isDate(day.date, inSameDayAs: currentDate)
        
      case "주":
        guard let weekStart = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start,
              let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart) else {
          return false
        }
        return day.date >= weekStart && day.date <= weekEnd
        
      case "월":
        return calendar.isDate(day.date, equalTo: currentDate, toGranularity: .month)
        
      default:
        return false
      }
    }
  }
  
  // 이전에 사용한 날짜 중 이동할 수 있는 가장 최근 날짜 반환
  private func getPreviousAvailableDate() -> Date? {
    let sortedDates = pomoDayData.map { $0.date }.sorted(by: >) // 최신순
    
    switch selectedPeriod {
    case "일":
      return sortedDates.first(where: { $0 < currentDate })
      
    case "주":
      let currentWeek = calendar.component(.weekOfYear, from: currentDate)
      let currentYear = calendar.component(.year, from: currentDate)
      
      return sortedDates.first(where: { date in
        let week = calendar.component(.weekOfYear, from: date)
        let year = calendar.component(.year, from: date)
        return year < currentYear || (year == currentYear && week < currentWeek)
      })
      
    case "월":
      let currentYearMonth = calendar.component(.year, from: currentDate) * 100
      + calendar.component(.month, from: currentDate)
      
      return sortedDates.first(where: { date in
        let yearMonth = calendar.component(.year, from: date) * 100
        + calendar.component(.month, from: date)
        return yearMonth < currentYearMonth
      })
      
    default:
      return nil
    }
  }
  
  // 다음에 사용한 날짜 중 이동할 수 있는 가장 가까운 날짜 반환
  private func getNextAvailableDate() -> Date? {
    let sortedDates = pomoDayData.map { $0.date }.sorted(by: <) // 과거순
    
    switch selectedPeriod {
    case "일":
      return sortedDates.first(where: { $0 > currentDate })
      
    case "주":
      let currentWeek = calendar.component(.weekOfYear, from: currentDate)
      let currentYear = calendar.component(.year, from: currentDate)
      
      return sortedDates.first(where: { date in
        let week = calendar.component(.weekOfYear, from: date)
        let year = calendar.component(.year, from: date)
        return year > currentYear || (year == currentYear && week > currentWeek)
      })
      
    case "월":
      let currentYearMonth = calendar.component(.year, from: currentDate) * 100
      + calendar.component(.month, from: currentDate)
      
      return sortedDates.first(where: { date in
        let yearMonth = calendar.component(.year, from: date) * 100
        + calendar.component(.month, from: date)
        return yearMonth > currentYearMonth
      })
      
    default:
      return nil
    }
  }
  
 
  // MARK: - ChartView용 함수
  // 태그별 집중시간 합산
  private func aggregateTagFocusTime(from pomoDays: [PomoDay]) -> [TagTimeRecord] {
    var tagMap: [String: TimeInterval] = [:]
    
    for day in pomoDays {
      for record in day.tagTimeRecords {
        tagMap[record.tagId, default: 0] += record.focusTime
      }
    }
    
    return tagMap.map { TagTimeRecord(tagId: $0.key, focusTime: $0.value) }
  }
  
  // 태그별 focusTime을 AppConfig의 tag 순서대로 정렬
  private func sortTagFocusData() {
    let appTags = pomoTodoUseCase.getAppConfig().tags
    tagFocusData.sort { record1, record2 in
      let idx1 = appTags.first(where: { $0.id == record1.tagId })?.index ?? Int.max
      let idx2 = appTags.first(where: { $0.id == record2.tagId })?.index ?? Int.max
      return idx1 < idx2
    }
  }
  
  // 태그 ID를 기반으로 태그 이름 찾기
  func getTagName(for tagId: String) -> String {
    return pomoTodoUseCase.getAppConfig().tags.first { $0.id == tagId }?.name ?? "Unknown"
  }
  
  // 태그 ID 기반으로 색상 찾기
  func getTagColor(for tagId: String) -> Color {
    guard let colorId = pomoTodoUseCase.getAppConfig().tags.first(where: { $0.id == tagId })?.colorId,
          let colorSet = Constants.Timer.colorSets.first(where: { $0.id == colorId }) else {
      return .gray // 기본 색상 (예외 처리)
    }
    return colorSet.normalColor
  }
  
}

// MARK: - Private Struct
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


// MARK: - 원본 함수 혹시 몰라서 백업용

//  // 저장된 포모도로 데이터 불러오기
//  private func loadPomoData() {
//    self.pomoDayData = pomoTodoUseCase.getAllPomoDays() // 여기 변경
//
//    // 가장 최신 날짜로 설정
//    if let latestDate = pomoDayData.map({ $0.date }).max() {
//      currentDate = latestDate
//    }
//
//    updateData()
//
//    // 초기에 버튼 활성화 상태 업데이트
//    updateButtonStates()
//  }

//  // 데이터 필터링 후 업데이트
//  func updateData() {
//    let filteredData = filterData(for: selectedPeriod)
//
//    totalPomodoro = filteredData.reduce(0) { $0 + $1.tomatoCnt }
//    totalSessions = filteredData.reduce(0) { $0 + $1.cycleCnt }
//    totalFocusTime = filteredData.reduce(0) { $0 + $1.totalTime }
//
//    // 전체 누적된 데이터 기준으로 총 집중시간과 세션 계산
//    allFocusTime = pomoDayData.reduce(0) { $0 + $1.totalTime }
//    allSessions = pomoDayData.reduce(0) { $0 + $1.cycleCnt }
//
//    // 사용한 일/주/월 수 가져오기 (실제 데이터 존재하는 기간 기준)
//    let (usedDays, usedWeeks, usedMonths) = getUsedPeriods()
//
//    // 기본적으로 "일간 평균" 계산
//    averageFocusTime = allFocusTime / Double(max(1, usedDays))
//    averageSessions = allSessions / Double(max(1, usedDays))
//
//    // 선택된 기간이 "주"라면 주간 기준으로 나눔
//    if selectedPeriod == "주" {
//      averageFocusTime = allFocusTime / Double(max(1, usedWeeks))
//      averageSessions = allSessions / Double(max(1, usedWeeks))
//    }
//
//    // 선택된 기간이 "월"이라면 월간 기준으로 나눔
//    if selectedPeriod == "월" {
//      averageFocusTime = allFocusTime / Double(max(1, usedMonths))
//      averageSessions = allSessions / Double(max(1, usedMonths))
//    }
//    // ‼️디버깅용 프린트 삭제
//    print("사용한 총 일수: \(usedDays), 주 수: \(usedWeeks), 월 수: \(usedMonths)")
//    print("평균 집중 시간 (일간 기준): \(averageFocusTime.formattedTime())")
//    print("평균 세션 (일간 기준): \(averageSessions)")
//
//    // 태그별 집중시간 데이터 정렬
//    tagFocusData = aggregateTagFocusTime(from: filteredData)
//    tagFocusData.sort { (tag1, tag2) in
//      let appTags = pomoTodoUseCase.getAppConfig().tags
//      let index1 = appTags.first { $0.id == tag1.tagId }?.index ?? Int.max
//      let index2 = appTags.first { $0.id == tag2.tagId }?.index ?? Int.max
//      return index1 < index2
//    }
//
//    updateDisplayDate()
//
//    // 버튼 상태 업데이트
//    updateButtonStates()
//  }
//
// 날짜 필터링 함수
//  private func filterData(for period: String) -> [PomoDay] {
//    return pomoDayData.filter { day in
//      switch period {
//      case "일":
//        return calendar.isDate(day.date, inSameDayAs: currentDate)
//      case "주":
//        guard let weekStart = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start else { return false }
//        guard let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart) else { return false }
//
//        return day.date >= weekStart && day.date <= weekEnd
//      case "월":
//        return calendar.isDate(day.date, equalTo: currentDate, toGranularity: .month)
//      default:
//        return false
//      }
//    }
//  }
//
// 태그별 집중시간 계산
//  private func aggregateTagFocusTime(from pomoDays: [PomoDay]) -> [TagTimeRecord] {
//    var tagMap: [String: TimeInterval] = [:]
//    for day in pomoDays {
//      for record in day.tagTimeRecords {
//        tagMap[record.tagId, default: 0] += record.focusTime
//      }
//    }
//    return tagMap.map { TagTimeRecord(tagId: $0.key, focusTime: $0.value) }
//  }
//
// 실제 사용한 "주"와 "월" 개수 반환
//  private func getUsedPeriods() -> (days: Int, weeks: Int, months: Int) {
//    let usedDays = Set(pomoDayData.map { calendar.startOfDay(for: $0.date) })
//
//    // 연도 + 주를 묶어서 Set에 저장
//    let usedWeeks = Set(pomoDayData.map {
//      YearWeek(year: calendar.component(.year, from: $0.date),
//               week: calendar.component(.weekOfYear, from: $0.date))
//    })
//
//    // 연도 + 월을 묶어서 Set에 저장
//    let usedMonths = Set(pomoDayData.map {
//      YearMonth(year: calendar.component(.year, from: $0.date),
//                month: calendar.component(.month, from: $0.date))
//    })
//
//    return (usedDays.count, usedWeeks.count, usedMonths.count)
//  }
//
// 날짜 업데이트 함수 (주간 & 월간 날짜 표시 수정)
//  private func updateDisplayDate() {
//    let dateFormatter = DateFormatter()
//
//    switch selectedPeriod {
//    case "일":
//      dateFormatter.dateFormat = "YYYY년 M월 d일"
//      displayDate = dateFormatter.string(from: currentDate)
//
//    case "주":
//      // 주간 범위 표시 수정
//      guard let weekStart = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start else { return }
//      guard let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart) else { return }
//
//      dateFormatter.dateFormat = "M월 d일"
//      displayDate = "\(dateFormatter.string(from: weekStart)) - \(dateFormatter.string(from: weekEnd))"
//
//    case "월":
//      dateFormatter.dateFormat = "YYYY년 M월"
//      displayDate = dateFormatter.string(from: currentDate)
//
//    default:
//      break
//    }
//  }
//
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
//
// 이전 날짜
//  func getPreviousAvailableDate() -> Date? {
//    let sortedDates = pomoDayData.map { $0.date }.sorted(by: >) // 최신순 정렬
//
//    switch selectedPeriod {
//    case "일":
//      return sortedDates.first(where: { $0 < currentDate }) // 가장 가까운 과거 날짜
//
//    case "주":
//      let currentWeek = calendar.component(.weekOfYear, from: currentDate)
//      let currentYear = calendar.component(.year, from: currentDate)
//
//      return sortedDates.first(where: { date in
//        let week = calendar.component(.weekOfYear, from: date)
//        let year = calendar.component(.year, from: date)
//        return year < currentYear || (year == currentYear && week < currentWeek)
//      })
//
//    case "월":
//      let currentYearMonth = (calendar.component(.year, from: currentDate) * 100) + calendar.component(.month, from: currentDate)
//
//      return sortedDates.first(where: { date in
//        let yearMonth = (calendar.component(.year, from: date) * 100) + calendar.component(.month, from: date)
//        return yearMonth < currentYearMonth // 현재 연월보다 작은 가장 가까운 데이터 찾기
//      })
//
//    default:
//      return nil
//    }
//  }

// 다음 날짜
//  func getNextAvailableDate() -> Date? {
//    let sortedDates = pomoDayData.map { $0.date }.sorted(by: <) // 과거순 정렬
//
//    switch selectedPeriod {
//    case "일":
//      return sortedDates.first(where: { $0 > currentDate }) // 가장 가까운 미래 날짜
//
//    case "주":
//      let currentWeek = calendar.component(.weekOfYear, from: currentDate)
//      let currentYear = calendar.component(.year, from: currentDate)
//
//      return sortedDates.first(where: { date in
//        let week = calendar.component(.weekOfYear, from: date)
//        let year = calendar.component(.year, from: date)
//        return year > currentYear || (year == currentYear && week > currentWeek)
//      })
//
//    case "월":
//      let currentYearMonth = (calendar.component(.year, from: currentDate) * 100) + calendar.component(.month, from: currentDate)
//
//      return sortedDates.first(where: { date in
//        let yearMonth = (calendar.component(.year, from: date) * 100) + calendar.component(.month, from: date)
//        return yearMonth > currentYearMonth // 현재 연월보다 큰 가장 가까운 데이터 찾기
//      })
//
//    default:
//      return nil
//    }
//  }
