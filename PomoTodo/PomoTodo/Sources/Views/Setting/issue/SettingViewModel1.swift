//
//  SettingViewModel.swift
//  PomoTodo
//
//  Created by 심근웅 on 2/19/25.
//

import Foundation
import SwiftUI
import Combine

@Observable
final class SettingViewModel_ {
  struct State {
    // Q) AppConfig 변수를 만들지, 지금 처럼 타이머, 태그로 만들지
    var config = AppConfig(pomoTimers: [], tags: [])
  }
  // 1. 태그 이름 변경
  // 2. 타이머 설정 변경(or 각 요소)
  enum Action {
    case timerChanged(timer: PomoTimer) // Q) timer를 전체 넘길지, 각 요소만 넘길지
    case nameChanged(id: String, name: String)
  }
  
  private(set) var state: State = .init()
  private var pomoTodoUseCase: PomoTodoUseCase
  
  init (pomoTodoUseCase: PomoTodoUseCase) {
    self.pomoTodoUseCase = pomoTodoUseCase
    self.state.config = pomoTodoUseCase.getAppConfig()
  }
  
  func send(_ action: Action) {
    switch action {
    case .nameChanged(let id, let name):
      if let index = state.config.tags.firstIndex(where: { $0.id == id }) {
        state.config.tags[index].name = name
      }
      pomoTodoUseCase.setAppConfig(
        state.config
      )
    case .timerChanged(let timer):
      if let index = state.config.pomoTimers.firstIndex(where: { $0.index == timer.index}) {
        state.config.pomoTimers[index] = timer
      }
      pomoTodoUseCase.setAppConfig(
        state.config
      )
    }
  }
}
