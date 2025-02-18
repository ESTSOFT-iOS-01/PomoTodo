//
//  AppConfig.swift
//  PomoTodo
//
//  Created by 신승재 on 2/18/25.
//

import Foundation

struct AppConfig: Equatable {
  var pomoTimers: [PomoTimer]
  var tags: [Tag]
}

struct PomoTimer: Equatable {
  var index: Int
  var focusTimeUnit: TimeInterval
  var tomatoPerCycle: Int
  var shortBreakUnit: TimeInterval
  var longBreakUnit: TimeInterval
}

struct Tag: Equatable {
  var id: String = UUID().uuidString
  var index: Int
  var name: String
  var colorId: Int
  
  static func == (lhs: Tag, rhs: Tag) -> Bool {
    return lhs.index == rhs.index &&
           lhs.name == rhs.name &&
           lhs.colorId == rhs.colorId
  }
}
