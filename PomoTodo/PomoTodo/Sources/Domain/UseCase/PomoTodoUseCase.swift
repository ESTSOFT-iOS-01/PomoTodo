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
  
  /// 앱의 기본 설정(`AppConfig`)을 업데이트하는 메서드
  /// - Parameter appConfig: 변경할 앱 설정 데이터(`AppConfig`)
  func setAppConfig(_ appConfig: AppConfig)
}
