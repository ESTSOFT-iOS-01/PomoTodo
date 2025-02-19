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
  
  convenience init(_ data: PomoDay) {
    self.init(
      date: data.date,
      tomatoCnt: data.tomatoCnt,
      cycleCnt: data.cycleCnt,
      tagTimeRecords: data.tagTimeRecords.map { TagTimeRecordDTO($0) },
      todos: data.todos.map { TodoDTO($0) }
    )
  }
}

extension PomoDayDTO {
  func toEntity() -> PomoDay {
    return PomoDay(
      date: self.date,
      tomatoCnt: self.tomatoCnt,
      cycleCnt: self.cycleCnt,
      tagTimeRecords: self.tagTimeRecords.map { $0.toEntity() },
      todos: self.todos
        .map { $0.toEntity() }
        .sorted { $0.createAt < $1.createAt }
    )
  }
}
