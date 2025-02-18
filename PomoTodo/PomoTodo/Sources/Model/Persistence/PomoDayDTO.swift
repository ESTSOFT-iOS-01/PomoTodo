//
//  PomoDayDTO.swift
//  PomoTodo
//
//  Created by 신승재 on 2/18/25.
//

import Foundation
import SwiftData

@Model
final class PomoDayDTO {
  var date: Date
  var tomatoCnt: Int
  var cycleCnt: Double
  
  @Relationship(deleteRule: .cascade)
  var tagTimeRecords: [TagTimeRecordDTO]
  
  @Relationship(deleteRule: .cascade)
  var todos: [TodoDTO]
  
  init(
    date: Date,
    tomatoCnt: Int,
    cycleCnt: Double,
    tagTimeRecords: [TagTimeRecordDTO],
    todos: [TodoDTO]
  ) {
    self.date = date
    self.tomatoCnt = tomatoCnt
    self.cycleCnt = cycleCnt
    self.tagTimeRecords = tagTimeRecords
    self.todos = todos
  }
}

@Model
final class TagTimeRecordDTO {
  var tagId: String
  var focusTime: TimeInterval
  
  init(tagId: String, focusTime: TimeInterval) {
    self.tagId = tagId
    self.focusTime = focusTime
  }
}

@Model
final class TodoDTO {
  var createAt: Date
  var tagId: String
  var name: String
  var isCompleted: Bool
  
  init(createAt: Date, tagId: String, name: String, isCompleted: Bool) {
    self.createAt = createAt
    self.tagId = tagId
    self.name = name
    self.isCompleted = isCompleted
  }
}
