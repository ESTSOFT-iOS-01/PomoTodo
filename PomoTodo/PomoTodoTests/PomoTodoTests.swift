//
//  PomoTodoTests.swift
//  PomoTodoTests
//
//  Created by 신승재 on 2/18/25.
//

import XCTest
@testable import PomoTodo

final class PomoTodoTests: XCTestCase {
  
  var appConfigRepository: AppConfigRepository?
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    let testSwiftDataStorage = SwiftDataStorage()
    appConfigRepository = AppConfigRepositoryImpl(
      modelContext: testSwiftDataStorage.modelContext
    )
  }
  
  override func tearDownWithError() throws {
    appConfigRepository = nil
    try super.tearDownWithError()
  }
  
  // MARK: - AppConfigRepository 테스트
  func testAppConfigRepository() throws {
    guard let appConfigRepository = appConfigRepository else {
      XCTFail("appConfigRepository should not be nil")
      return
    }
    
    // appconfig initialize & fetch Test
    appConfigRepository.initializeAppConfig()
    let initialFetchResult = appConfigRepository.getAppConfig()
    switch initialFetchResult {
    case .success(let appConfig):
      XCTAssertEqual(appConfig.pomoTimers, DefaultPreset.pomoTimers)
      XCTAssertEqual(appConfig.tags, DefaultPreset.tags)
    case .failure(let error):
      XCTFail("appConfig fetch error: \(error)")
    }
    
    // set Test
    let mokTag = Tag(index: 0, name: "hello", colorId: 120)
    appConfigRepository.setTags([mokTag])
    appConfigRepository.setFocusTimeUnit(
      pomoTimer: DefaultPreset.pomoTimers[0],
      time: .minute * 120
    )
    appConfigRepository.setLongBreakUnit(
      pomoTimer: DefaultPreset.pomoTimers[0],
      time: .minute * 120
    )
    appConfigRepository.setShortBreakUnit(
      pomoTimer: DefaultPreset.pomoTimers[0],
      time: .minute * 120
    )
    appConfigRepository.setTomatoPerCycle(
      pomoTimer: DefaultPreset.pomoTimers[0],
      tomato: 120
    )
    
    appConfigRepository.initializeAppConfig()
    let fetchResult = appConfigRepository.getAppConfig()
    switch fetchResult {
    case .success(let appConfig):
      print(appConfig)
    case .failure(let error):
      XCTFail("appConfig fetch error: \(error)")
    }
  }
}
