//
//  TodoDTO.swift
//  PomoTodo
//
//  Created by 신승재 on 2/18/25.
//

import Foundation
import SwiftData

@Model
final class TodoDTO {
  var id: String
  var createAt: Date
  var tagId: String
  var name: String
  var isCompleted: Bool
  
  init(
    id: String,
    createAt: Date,
    tagId: String,
    name: String,
    isCompleted: Bool
  ) {
    self.id = id
    self.createAt = createAt
    self.tagId = tagId
    self.name = name
    self.isCompleted = isCompleted
  }
  
  convenience init(_ data: Todo) {
    self.init(
      id: data.id,
      createAt: data.createAt,
      tagId: data.tagId,
      name: data.name,
      isCompleted: data.isCompleted
    )
  }
}

extension TodoDTO {
  func toEntity() -> Todo {
    return Todo(
      id: self.id,
      createAt: self.createAt,
      tagId: self.tagId,
      name: self.name,
      isCompleted: self.isCompleted
    )
  }
}
