//
//  StatisticsViewModel.swift
//  PomoTodo
//
//  Created by 도민준 on 2/18/25.
//

import SwiftUI

// 통계 뷰 모델
class StatisticsViewModel: ObservableObject {
  @Published var selectedPeriod: String = "일"
  @Published var displayDate: String = ""
  
  //  UI 데이터 저장
  @Published var totalPomodoro: Int = 0
  @Published var totalSessions: Double = 0
  @Published var totalFocusTime: TimeInterval = 0
  @Published var allFocusTime: TimeInterval = 0
  @Published var allSessions: Double = 0
  @Published var averageFocusTime: TimeInterval = 0
  @Published var averageSessions: Double = 0
  @Published var tagFocusData: [TagTimeRecord] = []
  
  private let calendar = Calendar.current
  private var currentDate = Date()
  private var pomoDayData: [PomoDay] = []
  
  
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
  
  // 태그 정보 (이제 뷰모델에서 관리)
  let fixedTags: [Tag] = [
    Tag(id: "1", index: 1, name: "공부", colorId: 1),
    Tag(id: "2", index: 2, name: "운동", colorId: 2),
    Tag(id: "3", index: 3, name: "독서", colorId: 3),
    Tag(id: "4", index: 4, name: "취미", colorId: 4)
  ]
  
  init() {
    loadSampleData()
  }
  
  // 더미 데이터 로드 (고정된 날짜)
  private func loadSampleData() {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd" // 날짜 형식 변경 (250219 → 2025-02-19 변환)
    
    // 사용자가 지정한 날짜 리스트
    let sampleDates = [
      "250219", "250211", "250206", "250204", "250116",
      "241225", "241023", "241021", "241010"
    ]
    
    pomoDayData = sampleDates.compactMap { dateString in
      guard let date = formatter.date(from: dateString) else { return nil }
      
      let tomatoCnt = 8  // 고정된 포모도로 수 (원하면 수정 가능)
      let cycleCnt = Double(tomatoCnt) / 8.0  // 8포모도로 1세션 기준
      let tagRecords: [TagTimeRecord] = [
        TagTimeRecord(tagId: "1", focusTime: 7200), // 공부 (2시간)
        TagTimeRecord(tagId: "2", focusTime: 3600), // 운동 (1시간)
        TagTimeRecord(tagId: "3", focusTime: 1800), // 독서 (30분)
        TagTimeRecord(tagId: "4", focusTime: 600)   // 취미 (10분)
      ]
      
      return PomoDay(
        date: date,
        tomatoCnt: tomatoCnt,
        cycleCnt: cycleCnt,
        tagTimeRecords: tagRecords,
        todos: [
          Todo(tagId: "1", name: "공부"),
          Todo(tagId: "2", name: "운동"),
          Todo(tagId: "3", name: "독서"),
          Todo(tagId: "4", name: "취미")
        ]
      )
    }
    
    updateData()
  }
  
  // 데이터 필터링 후 업데이트
  func updateData() {
    let filteredData = filterData(for: selectedPeriod)
    
    totalPomodoro = filteredData.reduce(0) { $0 + $1.tomatoCnt }
    totalSessions = filteredData.reduce(0) { $0 + $1.cycleCnt }
    totalFocusTime = filteredData.reduce(0) { $0 + $1.totalTime }
    
    // 전체 누적된 데이터 기준으로 총 집중시간과 세션 계산
    allFocusTime = pomoDayData.reduce(0) { $0 + $1.totalTime }
    allSessions = pomoDayData.reduce(0) { $0 + $1.cycleCnt }
    
    // 사용한 일/주/월 수 가져오기 (실제 데이터 존재하는 기간 기준)
    let (usedDays, usedWeeks, usedMonths) = getUsedPeriods()
    
    // 기본적으로 "일간 평균" 계산
    averageFocusTime = allFocusTime / Double(max(1, usedDays))
    averageSessions = allSessions / Double(max(1, usedDays))
    
    // 선택된 기간이 "주"라면 주간 기준으로 나눔
    if selectedPeriod == "주" {
      averageFocusTime = allFocusTime / Double(max(1, usedWeeks))
      averageSessions = allSessions / Double(max(1, usedWeeks))
    }
    
    // 선택된 기간이 "월"이라면 월간 기준으로 나눔
    if selectedPeriod == "월" {
      averageFocusTime = allFocusTime / Double(max(1, usedMonths))
      averageSessions = allSessions / Double(max(1, usedMonths))
    }
    
    print("사용한 총 일수: \(usedDays), 주 수: \(usedWeeks), 월 수: \(usedMonths)")
    print("평균 집중 시간 (일간 기준): \(averageFocusTime.formattedTime())")
    print("평균 세션 (일간 기준): \(averageSessions)")
    
    // 태그별 집중시간 데이터 정렬
    tagFocusData = aggregateTagFocusTime(from: filteredData)
    tagFocusData.sort { (tag1, tag2) in
      let index1 = fixedTags.first { $0.id == tag1.tagId }?.index ?? Int.max
      let index2 = fixedTags.first { $0.id == tag2.tagId }?.index ?? Int.max
      return index1 < index2
    }
    
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
  private func filterData(for period: String) -> [PomoDay] {
    return pomoDayData.filter { day in
      switch period {
      case "일":
        return calendar.isDate(day.date, inSameDayAs: currentDate)
      case "주":
        guard let weekStart = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start else { return false }
        guard let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart) else { return false }
        
        return day.date >= weekStart && day.date <= weekEnd
      case "월":
        return calendar.isDate(day.date, equalTo: currentDate, toGranularity: .month)
      default:
        return false
      }
    }
  }
  
  // 날짜 업데이트 함수 (주간 & 월간 날짜 표시 수정)
  private func updateDisplayDate() {
    let dateFormatter = DateFormatter()
    
    switch selectedPeriod {
    case "일":
      dateFormatter.dateFormat = "YYYY년 M월 d일"
      displayDate = dateFormatter.string(from: currentDate)
      
    case "주":
      // 🔥 주간 범위 표시 수정
      guard let weekStart = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start else { return }
      guard let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart) else { return }
      
      dateFormatter.dateFormat = "M월 d일"
      displayDate = "\(dateFormatter.string(from: weekStart)) - \(dateFormatter.string(from: weekEnd))"
      
    case "월":
      dateFormatter.dateFormat = "YYYY년 M월"
      displayDate = dateFormatter.string(from: currentDate)
      
    default:
      break
    }
  }
  
  // 날짜 이동 (저장된 데이터가 있는 날짜만 이동)
  func previousDate() {
    guard let previousDate = getPreviousAvailableDate() else { return }
    currentDate = previousDate
    updateData()
  }
  
  func nextDate() {
    guard let nextDate = getNextAvailableDate() else { return }
    currentDate = nextDate
    updateData()
  }
  
  // 이전 날짜
  func getPreviousAvailableDate() -> Date? {
    let sortedDates = pomoDayData.map { $0.date }.sorted(by: >) // 최신순 정렬
    
    switch selectedPeriod {
    case "일":
      return sortedDates.first(where: { $0 < currentDate }) // 가장 가까운 과거 날짜
      
    case "주":
      let currentWeek = calendar.component(.weekOfYear, from: currentDate)
      let currentYear = calendar.component(.year, from: currentDate)
      
      return sortedDates.first(where: { date in
        let week = calendar.component(.weekOfYear, from: date)
        let year = calendar.component(.year, from: date)
        return year < currentYear || (year == currentYear && week < currentWeek)
      })
      
    case "월":
      let currentYearMonth = (calendar.component(.year, from: currentDate) * 100) + calendar.component(.month, from: currentDate)
      
      return sortedDates.first(where: { date in
        let yearMonth = (calendar.component(.year, from: date) * 100) + calendar.component(.month, from: date)
        return yearMonth < currentYearMonth // 현재 연월보다 작은 가장 가까운 데이터 찾기
      })
      
    default:
      return nil
    }
  }
  
  // 다음 날짜
  func getNextAvailableDate() -> Date? {
    let sortedDates = pomoDayData.map { $0.date }.sorted(by: <) // 과거순 정렬
    
    switch selectedPeriod {
    case "일":
      return sortedDates.first(where: { $0 > currentDate }) // 가장 가까운 미래 날짜
      
    case "주":
      let currentWeek = calendar.component(.weekOfYear, from: currentDate)
      let currentYear = calendar.component(.year, from: currentDate)
      
      return sortedDates.first(where: { date in
        let week = calendar.component(.weekOfYear, from: date)
        let year = calendar.component(.year, from: date)
        return year > currentYear || (year == currentYear && week > currentWeek)
      })
      
    case "월":
      let currentYearMonth = (calendar.component(.year, from: currentDate) * 100) + calendar.component(.month, from: currentDate)
      
      return sortedDates.first(where: { date in
        let yearMonth = (calendar.component(.year, from: date) * 100) + calendar.component(.month, from: date)
        return yearMonth > currentYearMonth // 현재 연월보다 큰 가장 가까운 데이터 찾기
      })
      
    default:
      return nil
    }
  }
  
  
  
  
  // 태그 ID를 기반으로 태그 이름 찾기
  func getTagName(for tagId: String) -> String {
    return fixedTags.first { $0.id == tagId }?.name ?? "Unknown"
  }
  
  // 태그 ID 기반으로 색상 찾기
  func getTagColor(for tagId: String) -> Color {
    let colorMapping: [Int: Color] = [
      1: .indigoNormal,   // 공부
      2: .blueNormal,   // 운동
      3: .cyanNormal,   // 독서
      4: .tealNormal  // 취미
    ]
    
    let colorId = fixedTags.first { $0.id == tagId }?.colorId ?? 0
    let color = colorMapping[colorId] ?? .gray
    
    print("태그 ID: \(tagId), 매칭된 색상: \(color)") // 디버깅 로그 추가
    
    return color
  }
}
