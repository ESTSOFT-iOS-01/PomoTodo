//
//  PomoTodoUseCaseImpl.swift
//  PomoTodo
//
//  Created by 신승재 on 2/19/25.
//

import Foundation

final class PomoTodoUseCaseImpl: PomoTodoUseCase {
  
  private let pomoDayRepository: PomoDayRepository
  private let appConfigRepository: AppConfigRepository
  
  init(
    pomoDayRepository: PomoDayRepository,
    appConfigRepository: AppConfigRepository
  ) {
    self.pomoDayRepository = pomoDayRepository
    self.appConfigRepository = appConfigRepository
  }
  
  
  func getTodayPomoDay() -> PomoDay {
    print("Impl:", #function)
    
    let today = Date().formattedDate
    
    let result = pomoDayRepository.fetchPomoDay(date: today)
    switch result {
    case .success(let pomoDay):
      if let pomoDay {
        return pomoDay
      } else {
        return initializePomoDay()
      }
    case .failure(let error):
      fatalError("\(error)")
    }
  }
  
  
  func addTagTimeRecords(
    todayPomoDay: PomoDay,
    tagTimeRecord: TagTimeRecord
  ) {
    print("Impl:", #function)
    
    let result = pomoDayRepository.fetchPomoDay(date: todayPomoDay.date)
    switch result {
    case .success(let pomoDay):
      guard let pomoDay else { return }
      let newRecords = pomoDay.tagTimeRecords + [tagTimeRecord]
      let updatedPomoDay = PomoDay(
        date: pomoDay.date,
        tomatoCnt: pomoDay.tomatoCnt,
        cycleCnt: pomoDay.cycleCnt,
        tagTimeRecords: newRecords,
        todos: pomoDay.todos
      )
      pomoDayRepository.updatePomoDay(updatedPomoDay)
    case .failure(let error):
      print(error)
    }
    
  }
  
  func updateTomatoAndCycle(
    todayPomoDay: PomoDay,
    tomatoCnt: Int,
    cycleCnt: Double
  ) {
    print("Impl:", #function)
    
    let result = pomoDayRepository.fetchPomoDay(date: todayPomoDay.date)
    switch result {
    case .success(let pomoDay):
      guard let pomoDay else { return }
      let updatedPomoDay = PomoDay(
        date: pomoDay.date,
        tomatoCnt: tomatoCnt + pomoDay.tomatoCnt,
        cycleCnt: cycleCnt + pomoDay.cycleCnt,
        tagTimeRecords: pomoDay.tagTimeRecords,
        todos: pomoDay.todos
      )
      pomoDayRepository.updatePomoDay(updatedPomoDay)
    case .failure(let error):
      print(error)
    }
  }
  
  func getAllPomoDays() -> [PomoDay] {
    let result = pomoDayRepository.fetchAllPomoDays()
    switch result {
    case .success(let pomoDays):
      return pomoDays
    case .failure(let error):
      print(error)
      return []
    }
  }
  
  func getTodayTodos() -> [Todo] {
    print("Impl:", #function)
    
    let today = Date().formattedDate
    
    let result = pomoDayRepository.fetchPomoDay(date: today)
    switch result {
    case .success(let pomoDay):
      guard let pomoDay else {
        print("오늘의 PomoDay가 존재하지 않음")
        return []
      }
      return pomoDay.todos
    case .failure(let error):
      print(error)
      return []
    }
  }
  
  func setTodayTodos(_ todos: [Todo]) {
    print("Impl:", #function)
    
    let today = Date().formattedDate
    
    let result = pomoDayRepository.fetchPomoDay(date: today)
    switch result {
    case .success(let pomoDay):
      guard let pomoDay else {
        print("오늘의 PomoDay가 존재하지 않음")
        return
      }
      pomoDayRepository.setTodos(pomoDay: pomoDay, todos: todos)
    case .failure(let error):
      print(error)
    }
  }
  
  func getAppConfig() -> AppConfig {
    print("Impl:", #function)
    
    let result = appConfigRepository.fetchAppConfig()
    switch result {
    case .success(let appConfig):
      if let appConfig {
        return appConfig
      } else {
        return initializeAppConfig()
      }
    case .failure(let error):
      fatalError("\(error)")
    }
  }
  
  func setAppConfig(_ appConfig: AppConfig) {
    print("Impl:", #function)
    
    appConfigRepository.updateAppConfig(appConfig)
  }
}


extension PomoTodoUseCaseImpl {
  private func initializePomoDay() -> PomoDay {
    let today = Date().formattedDate
    let newPomoDay = PomoDay(
      date: today,
      tomatoCnt: 0,
      cycleCnt: 0.0,
      tagTimeRecords: [],
      todos: []
    )
    pomoDayRepository.createPomoDay(newPomoDay)
    return newPomoDay
  }
  
  private func initializeAppConfig() -> AppConfig {
    let newAppConfig = AppConfig(
      pomoTimers: DefaultPreset.pomoTimers,
      tags: DefaultPreset.tags
    )
    appConfigRepository.createAppConfig(newAppConfig)
    return newAppConfig
  }
}


enum DefaultPreset {
  static let pomoTimers: [PomoTimer] = [
    PomoTimer(index: 0, focusTimeUnit: 10, tomatoPerCycle: 2, shortBreakUnit: 2, longBreakUnit: 4),
    PomoTimer(index: 1, focusTimeUnit: 5, tomatoPerCycle: 4, shortBreakUnit: 3, longBreakUnit: 6),
    PomoTimer(index: 2, focusTimeUnit: .minute * 25, tomatoPerCycle: 4, shortBreakUnit: .minute * 5, longBreakUnit: .minute * 15),
  ]
  
  static let tags: [Tag] = [
    Tag(index: 0, name: "공부", colorId: 0),
    Tag(index: 1, name: "운동", colorId: 1),
    Tag(index: 2, name: "독서", colorId: 2),
    Tag(index: 3, name: "취미", colorId: 3)
  ]
}
