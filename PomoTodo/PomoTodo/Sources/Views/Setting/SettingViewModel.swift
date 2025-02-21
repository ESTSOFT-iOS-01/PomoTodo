//
//  SettingViewModel.swift
//  PomoTodo
//
//  Created by 심근웅 on 2/19/25.
//

import Foundation
import SwiftUI
import Combine

final class SettingViewModel: ObservableObject {
  
  @Published var config = AppConfig(pomoTimers: [], tags: [])
  
  enum Action {
    case onAppear
    case tagNameChanged(index: Int, name: String)
    case focusTimeUnitChanged(index: Int, value: Int)
    case tomatoPerCycleChanged(index: Int, value: Int)
    case shortBreakUnitChanged(index: Int, value: Int)
    case longBreakUnitChanged(index: Int, value: Int)
  }
  
  private var pomoTodoUseCase: PomoTodoUseCase
  
  init (pomoTodoUseCase: PomoTodoUseCase) {
    self.pomoTodoUseCase = pomoTodoUseCase
    self.config = pomoTodoUseCase.getAppConfig()
  }
  
  func send(_ action: Action) {
    switch action {
    case .onAppear:
      loadDate()
    case .tagNameChanged(let index, let name):
      config.tags[index].name = name
      pomoTodoUseCase.setAppConfig(config)
    case .focusTimeUnitChanged(let index, let value):
      config.pomoTimers[index].focusTimeUnit = value.asDouble * .minute
      pomoTodoUseCase.setAppConfig(config)
    case .tomatoPerCycleChanged(let index, let value):
      config.pomoTimers[index].tomatoPerCycle = value
      pomoTodoUseCase.setAppConfig(config)
    case .shortBreakUnitChanged(let index, let value):
      config.pomoTimers[index].shortBreakUnit = value.asDouble * .minute
      pomoTodoUseCase.setAppConfig(config)
    case .longBreakUnitChanged(let index, let value):
      config.pomoTimers[index].longBreakUnit = value.asDouble * .minute
      pomoTodoUseCase.setAppConfig(config)
    }
  }
}

extension SettingViewModel {
  private func loadDate() {
    self.config = pomoTodoUseCase.getAppConfig()
  }
}

