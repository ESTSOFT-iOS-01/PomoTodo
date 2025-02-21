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
  }
//case focusTimeUnitChanged(index: Int, value: Int)
//case tomatoPerCycleChanged(index: Int, value: Int)
//case shortBreakUnitChanged(index: Int, value: Int)
//case longBreakUnitChanged(index: Int, value: Int)
//case tagChanged
 
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

    }
  }
  
//  func send(_ action: Action) {
//    switch action {
//    case .focusTimeUnitChanged(let index, let value):
//      self.timers[index].focusTimeUnit = Double(value) * .minute
//      pomoTodoUseCase.setAppConfig(
//        AppConfig(pomoTimers: self.timers, tags: tags)
//      )
//    case .tomatoPerCycleChanged(let index, let value):
//      self.timers[index].tomatoPerCycle = value
//      pomoTodoUseCase.setAppConfig(
//        AppConfig(pomoTimers: self.timers, tags: tags)
//      )
//    case .shortBreakUnitChanged(let index, let value):
//      self.timers[index].shortBreakUnit = Double(value) * .minute
//      pomoTodoUseCase.setAppConfig(
//        AppConfig(pomoTimers: self.timers, tags: tags)
//      )
//    case .longBreakUnitChanged(let index, let value):
//      self.timers[index].longBreakUnit = Double(value) * .minute
//      pomoTodoUseCase.setAppConfig(
//        AppConfig(pomoTimers: self.timers, tags: tags)
//      )
//    case .tagChanged:
//      pomoTodoUseCase.setAppConfig(
//        AppConfig(pomoTimers: self.timers, tags: tags)
//      )
//    }
//  }
}

extension SettingViewModel {
  private func loadDate() {
    self.config = pomoTodoUseCase.getAppConfig()
  }
}
