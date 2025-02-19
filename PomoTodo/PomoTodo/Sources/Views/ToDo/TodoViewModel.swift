//
//  TodoViewModel.swift
//  PomoTodo
//
//  Created by 신승재 on 2/19/25.
//

import Foundation

@Observable
final class TodoViewModel {
  struct State {
    var todos: [Todo] = []
    var appConfig: AppConfig = AppConfig(pomoTimers: [], tags: DefaultPreset.tags)
  }
  
  enum Action {
    case onAppear
  }
  
  private(set) var state: State = .init()
  
  init() {
    
  }
  
  func send(_ action: Action) {
      switch action {
      case .onAppear:
        print("onAppear")
      }
    }
  }
