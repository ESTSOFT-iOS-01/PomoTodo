//
//  DIContainer.swift
//  PomoTodo
//
//  Created by 신승재 on 2/19/25.
//

import Foundation

@Observable
final class DIContainer {
  private let storage: SwiftDataStorage
  
  private let appConfigRepository: AppConfigRepository
  private let pomoDayRepository: PomoDayRepository
  let pomoTodoUseCase: PomoTodoUseCase
  
  init() {
    self.storage = SwiftDataStorage()
    self.appConfigRepository = AppConfigRepositoryImpl(
      modelContext: storage.modelContext
    )
    self.pomoDayRepository = PomoDayRepositoryImpl(
      modelContext: storage.modelContext
    )
    self.pomoTodoUseCase = PomoTodoUseCaseImpl(
      pomoDayRepository: pomoDayRepository,
      appConfigRepository: appConfigRepository
    )
  }
}
