//
//  AppConfigRepositoryImpl.swift
//  PomoTodo
//
//  Created by 신승재 on 2/18/25.
//

import Foundation
import SwiftData

final class AppConfigRepositoryImpl {
  
  private let modelContext: ModelContext
  
  init(modelContext: ModelContext) {
    self.modelContext = modelContext
  }
  
  func initializeAppConfig() {
    print("Impl:", #function)
    
    let pomoTimersDTO = DefaultPreset.pomoTimers.map { PomoTimerDTO($0) }
    let tagsDTO = DefaultPreset.tags.map { TagDTO($0) }
    
    let result = findAppConfig()
    switch result {
    case .success:
      print(SwiftDataError.modelAlreadyExist)
    case .failure(.modelNotFound):
      let model = AppConfigDTO(pomoTimers: pomoTimersDTO, tags: tagsDTO)
      modelContext.insert(model)
    case .failure(let error):
      print(error)
    }
  }
  
  func getAppConfig() -> Result<AppConfig, SwiftDataError> {
    print("Impl:", #function)
    
    let result = findAppConfig()
    switch result {
    case .success(let model):
      return .success(model.toEntity())
    case .failure(let error):
      return .failure(error)
    }
  }
  
  func setFocusTimeUnit(pomoTimer: PomoTimer, time: TimeInterval) {
    print("Impl:", #function)
    
    let result = findPomoTimer(pomoTimer: pomoTimer)
    switch result {
    case .success(let model):
      model.focusTimeUnit = time
    case .failure(let error):
      print(error)
    }
  }
  
  
  func setTomatoPerCycle(pomoTimer: PomoTimer, tomato: Int) {
    print("Impl:", #function)
    
    let result = findPomoTimer(pomoTimer: pomoTimer)
    switch result {
    case .success(let model):
      model.tomatoPerCycle = tomato
    case .failure(let error):
      print(error)
    }
  }
  
  
  func setShortBreakUnit(pomoTimer: PomoTimer, time: TimeInterval) {
    print("Impl:", #function)
    
    let result = findPomoTimer(pomoTimer: pomoTimer)
    switch result {
    case .success(let model):
      model.shortBreakUnit = time
    case .failure(let error):
      print(error)
    }
  }
  
  
  func setLongBreakUnit(pomoTimer: PomoTimer, time: TimeInterval) {
    print("Impl:", #function)
    
    let result = findPomoTimer(pomoTimer: pomoTimer)
    switch result {
    case .success(let model):
      model.longBreakUnit = time
    case .failure(let error):
      print(error)
    }
  }
  
  
  func setTags(_ tags: [Tag]) {
    print("Impl:", #function)
    
    let result = findAppConfig()
    switch result {
    case .success(let model):
      model.tags.forEach { modelContext.delete($0) }
      model.tags = tags.map { TagDTO($0) }
    case .failure(let error):
      print(error)
    }
  }
}

extension AppConfigRepositoryImpl {
  
  private func findAppConfig() -> Result<AppConfigDTO, SwiftDataError> {
    print("Impl:", #function)
    
    let descriptor = FetchDescriptor<AppConfigDTO>()
    
    do {
      guard let data = try modelContext.fetch(descriptor).first else {
        return .failure(.modelNotFound)
      }
      return .success(data)
    } catch {
      return .failure(.fetchError)
    }
  }
  
  private func findPomoTimer(
    pomoTimer: PomoTimer
  ) -> Result<PomoTimerDTO, SwiftDataError> {
    print("Impl:", #function)
    
    let index = pomoTimer.index
    let predicate = #Predicate<PomoTimerDTO> { $0.index ==  index }
    let descriptor = FetchDescriptor<PomoTimerDTO>(predicate: predicate)
    
    do {
      guard let data = try modelContext.fetch(descriptor).first else {
        return .failure(.modelNotFound)
      }
      return .success(data)
    } catch {
      return .failure(.fetchError)
    }
  }
}


