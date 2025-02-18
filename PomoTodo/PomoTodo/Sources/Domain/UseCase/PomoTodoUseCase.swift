//
//  PomoTodoUseCase.swift
//  PomoTodo
//
//  Created by 신승재 on 2/19/25.
//

import Foundation


protocol PomoTodoUseCase {
  
  // MARK: - TimerUseCase
  
  /// 오늘의 `PomoDay`를 가져오는 메서드
  /// - 만약 기존에 데이터가 없으면 새로운 `PomoDay`를 생성하여 반환
  /// - Returns: 오늘 날짜의 `PomoDay`
  func getTodayPomoDay() -> PomoDay
  
  /// 특정 타이머 프리셋에 따라 `tagTimeRecord`를 추가하는 메서드
  /// - Parameters:
  ///   - presetIndex: 타이머 프리셋의 인덱스
  ///   - todayPomoDay: 오늘의 `PomoDay`
  ///   - tagTimeRecord: 추가할 `TagTimeRecord`
  func addTagTimeRecords(
    presetIndex: Int,
    todayPomoDay: PomoDay,
    tagTimeRecord: TagTimeRecord
  )
  
  // MARK: - StatsUseCase
  
  /// 특정 날짜의 `PomoDay` 데이터를 가져오는 메서드
  /// - Parameter date: 조회할 날짜
  /// - Returns: 해당 날짜의 `PomoDay`, 존재하지 않으면 `nil`
  func getPomoDayByDate(_ date: Date) -> PomoDay?
  
  /// 특정 날짜를 기준으로 해당 주의 `PomoDay` 데이터를 가져오는 메서드
  /// - Parameter date: 기준 날짜
  /// - Returns: 기준 날짜가 속한 주의 `PomoDay` 리스트
  func getWeeklyPomoDaysByDate(_ date: Date) -> [PomoDay]
  
  /// 특정 날짜를 기준으로 해당 월의 `PomoDay` 데이터를 가져오는 메서드
  /// - Parameter date: 기준 날짜
  /// - Returns: 기준 날짜가 속한 월의 `PomoDay` 리스트
  func getMonthlyPomoDaysByDate(_ date: Date) -> [PomoDay]
  
  // MARK: - TodoUseCase
  
  /// 오늘의 `Todo` 목록을 가져오는 메서드
  /// - Returns: 오늘 생성된 `Todo` 리스트
  func getTodayTodos() -> [Todo]
  
  /// 오늘의 `Todo` 목록을 설정하는 메서드
  /// - Parameter todos: 저장할 `Todo` 리스트
  func setTodayTodos(_ todos: [Todo])
  
  // MARK: - AppConfigUseCase
  
  /// 앱의 기본 설정(`AppConfig`)을 가져오는 메서드
  /// - Returns: 현재 앱의 설정 데이터(`AppConfig`)
  func getAppConfig() -> AppConfig
  
  /// 특정 타이머 프리셋의 집중 시간을 설정하는 메서드
  /// - Parameters:
  ///   - pomoTimer: 변경할 `PomoTimer`
  ///   - time: 변경할 시간(`TimeInterval`)
  func setFocusTimeUnit(pomoTimer: PomoTimer, time: TimeInterval)
  
  /// 특정 타이머 프리셋의 `토마토 개수`를 설정하는 메서드
  /// - Parameters:
  ///   - pomoTimer: 변경할 `PomoTimer`
  ///   - tomatoCnt: 변경할 토마토 개수
  func setTomatoPerCycle(pomoTimer: PomoTimer, tomatoCnt: Int)
  
  /// 특정 타이머 프리셋의 `짧은 휴식 시간`을 설정하는 메서드
  /// - Parameters:
  ///   - pomoTimer: 변경할 `PomoTimer`
  ///   - time: 변경할 시간(`TimeInterval`)
  func setShortBreakUnit(pomoTimer: PomoTimer, time: TimeInterval)
  
  /// 특정 타이머 프리셋의 `긴 휴식 시간`을 설정하는 메서드
  /// - Parameters:
  ///   - pomoTimer: 변경할 `PomoTimer`
  ///   - time: 변경할 시간(`TimeInterval`)
  func setLongBreakUnit(pomoTimer: PomoTimer, time: TimeInterval)
  
  /// `Tag` 목록을 설정하는 메서드
  /// - Parameter tags: 저장할 `Tag` 리스트
  func setTags(_ tags: [Tag])
}
