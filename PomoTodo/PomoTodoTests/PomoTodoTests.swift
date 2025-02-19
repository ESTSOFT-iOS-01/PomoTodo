//
//  PomoTodoTests.swift
//  PomoTodoTests
//
//  Created by 신승재 on 2/18/25.
//

import XCTest
@testable import PomoTodo

final class PomoTodoTests: XCTestCase {
  
  var pomoTodoUseCase: PomoTodoUseCase?
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    let testSwiftDataStorage = SwiftDataStorage()
    let appConfigRepository = AppConfigRepositoryImpl(
      modelContext: testSwiftDataStorage.modelContext
    )
    let pomoDayRepository = PomoDayRepositoryImpl(
      modelContext: testSwiftDataStorage.modelContext
    )
    pomoTodoUseCase = PomoTodoUseCaseImpl(
      pomoDayRepository: pomoDayRepository,
      appConfigRepository: appConfigRepository
    )
  }
  
  override func tearDownWithError() throws {
    pomoTodoUseCase = nil
    try super.tearDownWithError()
  }
  
  // MARK: - PomoTodoUseCase 테스트
  func testPomoTodoUseCase() throws {
    guard let pomoTodoUseCase = pomoTodoUseCase else {
      XCTFail("pomoTodoUseCase should not be nil")
      return
    }
    
    // appConfig create test
    let appConfig = pomoTodoUseCase.getAppConfig()
    print(appConfig)
    
    // appConfig fetch test
    let fetchAppConfig = pomoTodoUseCase.getAppConfig()
    XCTAssertEqual(appConfig, fetchAppConfig, "appConfig가 일치하지 않습니다.")
    
    // pomoDay create test
    let pomoDay = pomoTodoUseCase.getTodayPomoDay()
    print(pomoDay)
    
    // pomoDay fetch test
    let fetchTodayPomoDay = pomoTodoUseCase.getTodayPomoDay()
    XCTAssertEqual(pomoDay, fetchTodayPomoDay, "오늘의 Pomodoro Day가 일치하지 않습니다.")
    
    
  }
}
