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
  
  init() {
    self.repositoryProvider = RepositoryProvider()
  }
  
  func makeToDoViewModel() -> ToDoViewModel {
    ToDoViewModel(
      pomoTodoUseCase: PomoTodoUseCaseImpl(
        pomoDayRepository: repositoryProvider.pomoDayRepository,
        appConfigRepository: repositoryProvider.appConfigRepository
      )
    )
  }
  
  func makePomoViewModel() -> PomoViewModel {
    PomoViewModel(
      pomoTodoUseCase: PomoTodoUseCaseImpl(
        pomoDayRepository: repositoryProvider.pomoDayRepository,
        appConfigRepository: repositoryProvider.appConfigRepository
      )
    )
  }
  
  func makeSettingViewModel() -> SettingViewModel {
    SettingViewModel(
      pomoTodoUseCase: PomoTodoUseCaseImpl(
        pomoDayRepository: repositoryProvider.pomoDayRepository,
        appConfigRepository: repositoryProvider.appConfigRepository
      )
    )
  }
  
  func makeStatisticsViewModel() -> StatisticsViewModel {
    StatisticsViewModel(
      pomoTodoUseCase: PomoTodoUseCaseImpl(
        pomoDayRepository: repositoryProvider.pomoDayRepository,
        appConfigRepository: repositoryProvider.appConfigRepository
      )
    )
  }
}
