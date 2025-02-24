//
//  ToDoViewModel.swift
//  PomoTodo
//
//  Created by 신승재 on 2/19/25.
//

import Foundation


final class ToDoViewModel: ObservableObject {
  
  // MARK: - UI State
  @Published var todos: [Todo] = []
  @Published var tags: [Tag] = []
  
  enum Action {
    case onAppear
    case addEmptyTodo(tagId: String)
    case deleteTodo(id: String)
    case toggleTodo(id: String, status: Bool)
    case nameChanged(id: String, name: String)
  }
  
  private var pomoTodoUseCase: PomoTodoUseCase
  
  init (pomoTodoUseCase: PomoTodoUseCase) {
    self.pomoTodoUseCase = pomoTodoUseCase
    loadData()
  }
  
  func send(_ action: Action) {
    switch action {
    case .onAppear:
      loadData()
      
    case .addEmptyTodo(let tagId):
      let emptyTodo = Todo(tagId: tagId, name: "")
      todos.append(emptyTodo)
      pomoTodoUseCase.setTodayTodos(todos)
    case .deleteTodo(let id):
      if let index = todos.firstIndex(where: { $0.id == id }) {
        self.todos.remove(at: index)
      }
      pomoTodoUseCase.setTodayTodos(todos)
    case .toggleTodo(let id, let status):
      if let index = todos.firstIndex(where: { $0.id == id }) {
        todos[index].isCompleted = status
      }
      pomoTodoUseCase.setTodayTodos(todos)
    case .nameChanged(let id, let name):
      if let index = todos.firstIndex(where: { $0.id == id }) {
        todos[index].name = name
      }
      pomoTodoUseCase.setTodayTodos(todos)
    }
  }
}

extension ToDoViewModel {
  // MARK: - Private function
  private func loadData() {
    self.tags = pomoTodoUseCase.getAppConfig().tags
    self.todos = pomoTodoUseCase.getTodayTodos()
    if todos.isEmpty {
      tags.forEach {
        todos.append(Todo(tagId: $0.id, name: ""))
      }
    }
  }
}
