//
//  AppConfigRepositoryImpl.swift
//  PomoTodo
//
//  Created by 신승재 on 2/18/25.
//

import Foundation
import SwiftData

final class AppConfigRepositoryImpl: AppConfigRepository {
  
  private let modelContext: ModelContext
  
  init(modelContext: ModelContext) {
    self.modelContext = modelContext
  }
  
  func createAppConfig(_ appConfig: AppConfig) {
    print("Impl:", #function)
    
    let result = findAppConfig()
    switch result {
    case .success:
      print(SwiftDataError.modelAlreadyExist)
    case .failure(.modelNotFound):
      let model = AppConfigDTO(appConfig)
      modelContext.insert(model)
    case .failure(let error):
      print(error)
    }
  }

  func fetchAppConfig() -> Result<AppConfig?, any Error> {
    print("Impl:", #function)
    
    let descriptor = FetchDescriptor<AppConfigDTO>()
    
    do {
      guard let data = try modelContext.fetch(descriptor).first else {
        print(SwiftDataError.modelNotFound)
        return .success(nil)
      }
      return .success(data.toEntity())
    } catch {
      return .failure(SwiftDataError.fetchError)
    }
  }

  func updateAppConfig(_ appConfig: AppConfig) {
    print("Impl:", #function)
    
    let result = findAppConfig()
    switch result {
    case .success(let model):
      model.pomoTimers = appConfig.pomoTimers.map { PomoTimerDTO($0) }
      model.tags = appConfig.tags.map { TagDTO($0) }
    case .failure(let error):
      print(error)
    }
  }

  func fetchPomoTimer(index: Int) -> Result<PomoTimer, any Error> {
    print("Impl:", #function)
    
    let targetIndex = index
    let predicate = #Predicate<PomoTimerDTO> { $0.index ==  targetIndex }
    let descriptor = FetchDescriptor<PomoTimerDTO>(predicate: predicate)
    
    do {
      guard let data = try modelContext.fetch(descriptor).first else {
        return .failure(SwiftDataError.modelNotFound)
      }
      return .success(data.toEntity())
    } catch {
      return .failure(SwiftDataError.fetchError)
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
}


