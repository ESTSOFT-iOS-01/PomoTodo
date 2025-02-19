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
  private var container = DIContainer()
  
  var body: some Scene {
    WindowGroup {
      MainTabBarView()
        .environment(container)
    }
  }
}
