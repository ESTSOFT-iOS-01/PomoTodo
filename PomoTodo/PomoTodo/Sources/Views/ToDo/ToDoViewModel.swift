//
//  ToDoViewModel.swift
//  PomoTodo
//
//  Created by 신승재 on 2/19/25.
//

import Foundation

@Observable
final class ToDoViewModel {
  struct State {
    var todos: [Todo] = []
    var tags: [Tag] = []
  }
  
  enum Action {
    case addEmptyTodo(tagId: String)
    case deleteTodo(id: String)
    case toggleTodo(id: String, status: Bool)
    case nameChanged(id: String, name: String)
  }
  
  private(set) var state: State = .init()
  private var pomoTodoUseCase: PomoTodoUseCase
  
  init (pomoTodoUseCase: PomoTodoUseCase) {
    self.pomoTodoUseCase = pomoTodoUseCase
    self.state.tags = pomoTodoUseCase.getAppConfig().tags
    self.state.todos = pomoTodoUseCase.getTodayTodos()
  }
  
  func send(_ action: Action) {
    switch action {
    case .addEmptyTodo(let tagId):
      let emptyTodo = Todo(tagId: tagId, name: "")
      state.todos.append(emptyTodo)
      pomoTodoUseCase.setTodayTodos(
        state.todos
      )
    case .deleteTodo(let id):
      if let index = state.todos.firstIndex(where: { $0.id == id }) {
        state.todos.remove(at: index)
      }
      pomoTodoUseCase.setTodayTodos(
        state.todos
      )
    case .toggleTodo(let id, let status):
      if let index = state.todos.firstIndex(where: { $0.id == id }) {
        state.todos[index].isCompleted = status
      }
      pomoTodoUseCase.setTodayTodos(
        state.todos
      )
    case .nameChanged(let id, let name):
      if let index = state.todos.firstIndex(where: { $0.id == id }) {
        state.todos[index].name = name
      }
      pomoTodoUseCase.setTodayTodos(
        state.todos
      )
    }
  }
}
