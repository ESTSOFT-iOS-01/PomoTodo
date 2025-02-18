//
//  AppConfig.swift
//  PomoTodo
//
//  Created by 신승재 on 2/18/25.
//

import Foundation

struct AppConfig {
  var pomoTimers: [PomoTimer]
  var tags: [Tag]
}

struct PomoTimer {
  var index: Int
  var focusTimeUnit: TimeInterval
  var tomatoPerCycle: Int
  var shortBreakUnit: TimeInterval
  var longBreakUnit: TimeInterval
}

struct Tag {
  var id: String = UUID().uuidString
  var index: Int
  var name: String
  var colorId: Int
}
