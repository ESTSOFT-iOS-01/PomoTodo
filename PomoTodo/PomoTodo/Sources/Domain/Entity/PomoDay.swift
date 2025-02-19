//
//  PomoDay.swift
//  PomoTodo
//
//  Created by 신승재 on 2/18/25.
//

import Foundation

struct PomoDay: Equatable {
  var date: Date
  var tomatoCnt: Int
  var cycleCnt: Double
  var totalTime: TimeInterval {
    tagTimeRecords.reduce(0) { $0 + $1.focusTime }
  }
  
  var tagTimeRecords: [TagTimeRecord]
  var todos: [Todo]
}

struct TagTimeRecord: Equatable {
  var tagId: String
  var focusTime: TimeInterval
}

struct Todo: Identifiable, Equatable {
  var id: String = UUID().uuidString
  var createAt: Date = Date()
  var tagId: String
  var name: String
  var isCompleted: Bool = false
  
  static func == (lhs: Todo, rhs: Todo) -> Bool {
    return lhs.createAt == rhs.createAt &&
           lhs.tagId == rhs.tagId &&
           lhs.name == rhs.name &&
           lhs.isCompleted == rhs.isCompleted
  }
}
