//
//  DIContainer.swift
//  PomoTodo
//
//  Created by 신승재 on 2/19/25.
//

import Foundation

@Observable
final class DIContainer {
  
  static let shared = DIContainer()
  
  private let repositoryProvider: RepositoryProvider
  let pomoTodoUseCase: PomoTodoUseCase
  
  init() {
    self.repositoryProvider = RepositoryProvider()
    pomoTodoUseCase = PomoTodoUseCaseImpl(
      pomoDayRepository: repositoryProvider.pomoDayRepository,
      appConfigRepository: repositoryProvider.appConfigRepository
    )
    _ = pomoTodoUseCase.getTodayPomoDay()
  }
  
  func makeToDoViewModel() -> ToDoViewModel {
    ToDoViewModel(
      pomoTodoUseCase: pomoTodoUseCase
    )
  }
  
  func makePomoViewModel() -> PomoViewModel {
    PomoViewModel(
      pomoTodoUseCase: pomoTodoUseCase
    )
  }
  
  func makeSettingViewModel() -> SettingViewModel {
    SettingViewModel(
      pomoTodoUseCase: pomoTodoUseCase
    )
  }
  
  func makeStatisticsViewModel() -> StatisticsViewModel {
    StatisticsViewModel(
      pomoTodoUseCase: pomoTodoUseCase
    )
  }
}
