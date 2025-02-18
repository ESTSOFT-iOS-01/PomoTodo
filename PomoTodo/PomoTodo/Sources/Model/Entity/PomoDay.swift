//
//  PomoDay.swift
//  PomoTodo
//
//  Created by 신승재 on 2/18/25.
//

import Foundation

struct PomoDay {
  var date: Date
  var tomatoCnt: Int
  var cycleCnt: Double
  var totalTime: TimeInterval {
    tagTimeRecords.reduce(0) { $0 + $1.focusTime }
  }
  
  var tagTimeRecords: [TagTimeRecord]
  var todos: [Todo]
}

struct TagTimeRecord {
  var tagId: String
  var focusTime: TimeInterval
}

struct Todo: Identifiable {
  var id: String = UUID().uuidString
  var createAt: Date = Date()
  var tagId: String
  var name: String
  var isCompleted: Bool = false
}
