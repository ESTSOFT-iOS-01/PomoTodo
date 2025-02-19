//
//  PomoTodoApp.swift
//  PomoTodo
//
//  Created by 신승재 on 2/17/25.
//

import SwiftUI
import SwiftData

@main
struct PomoTodoApp: App {
  // TODO: DI 리팩토링
  let pomoTodoUseCase: PomoTodoUseCase
  
  init() {
    let storage = SwiftDataStorage()
    let appConfigRepository = AppConfigRepositoryImpl(
      modelContext: storage.modelContext
    )
    let pomoDayRepository = PomoDayRepositoryImpl(
      modelContext: storage.modelContext
    )
    pomoTodoUseCase = PomoTodoUseCaseImpl(
      pomoDayRepository: pomoDayRepository,
      appConfigRepository: appConfigRepository
    )
  }
  
  var body: some Scene {
    WindowGroup {
      MainTabBarView(pomoTodoUseCase: pomoTodoUseCase)
    }
  }
}
