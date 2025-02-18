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

struct Todo {
  var createAt: Date = Date()
  var tagId: String
  var name: String
  var isCompleted: Bool = false
}

// 샘플 데이터 생성
let samplePomoDays: [PomoDay] = [
    PomoDay(
        date: Date(),
        tomatoCnt: 5,
        cycleCnt: 2.5,
        tagTimeRecords: [
            TagTimeRecord(tagId: "공부", focusTime: 3600),
            TagTimeRecord(tagId: "운동", focusTime: 1800),
            TagTimeRecord(tagId: "취미", focusTime: 1800),
            TagTimeRecord(tagId: "독서", focusTime: 1800)
        ],
        todos: [
            Todo(tagId: "공부", name: "수학 공부", isCompleted: true),
            Todo(tagId: "운동", name: "조깅", isCompleted: false),
            Todo(tagId: "운동", name: "조깅", isCompleted: false),
            Todo(tagId: "운동", name: "조깅", isCompleted: false)
        ]
    )
]
