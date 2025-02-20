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
  @Published var tags: [Tag] = []
  @Published var timers: [PomoTimer] = []
  @Published var pomoName: [String] = ["1번 프리셋","2번 프리셋","3번 프리셋"]
  
  struct State {
    var config = AppConfig(pomoTimers: [], tags: [])
  }
  enum Action {
    case focusTimeUnitChanged(index: Int, value: Int)
    case tomatoPerCycleChanged(index: Int, value: Int)
    case shortBreakUnitChanged(index: Int, value: Int)
    case longBreakUnitChanged(index: Int, value: Int)
    case tagChanged
  }
  
  private(set) var state: State = .init()
  private var pomoTodoUseCase: PomoTodoUseCase
  private var m: Int = Int(TimeInterval.minute)
  
  init (pomoTodoUseCase: PomoTodoUseCase) {
    self.pomoTodoUseCase = pomoTodoUseCase
    self.state.config = pomoTodoUseCase.getAppConfig()
    self.tags = self.state.config.tags
    self.timers = self.state.config.pomoTimers
  }
  
  func send(_ action: Action) {
    switch action {
    case .focusTimeUnitChanged(let index, let value):
      self.timers[index].focusTimeUnit = Double(value * m)
      pomoTodoUseCase.setAppConfig(
        AppConfig(pomoTimers: self.timers, tags: tags)
      )
    case .tomatoPerCycleChanged(let index, let value):
      self.timers[index].tomatoPerCycle = value
      pomoTodoUseCase.setAppConfig(
        AppConfig(pomoTimers: self.timers, tags: tags)
      )
    case .shortBreakUnitChanged(let index, let value):
      self.timers[index].shortBreakUnit = Double(value * m)
      pomoTodoUseCase.setAppConfig(
        AppConfig(pomoTimers: self.timers, tags: tags)
      )
    case .longBreakUnitChanged(let index, let value):
      self.timers[index].longBreakUnit = Double(value * m)
      pomoTodoUseCase.setAppConfig(
        AppConfig(pomoTimers: self.timers, tags: tags)
      )
    case .tagChanged:
      pomoTodoUseCase.setAppConfig(
        AppConfig(pomoTimers: self.timers, tags: tags)
      )
    }
  }
}
