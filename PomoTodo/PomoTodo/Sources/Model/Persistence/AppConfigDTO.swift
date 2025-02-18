//
//  AppConfigDTO.swift
//  PomoTodo
//
//  Created by 신승재 on 2/18/25.
//

import Foundation
import SwiftData

@Model
final class AppConfigDTO {
  
  @Relationship(deleteRule: .cascade)
  var pomoTimers: [PomoTimerDTO]
  
  @Relationship(deleteRule: .cascade)
  var tags: [TagDTO]
  
  init(pomoTimers: [PomoTimerDTO], tags: [TagDTO]) {
    self.pomoTimers = pomoTimers
    self.tags = tags
  }
}

@Model
final class PomoTimerDTO {
  var index: Int
  var focusTimeUnit: TimeInterval
  var tomatoPerCycle: Int
  var shortBreakUnit: TimeInterval
  var longBreakUnit: TimeInterval
  
  init(
    index: Int,
    focusTimeUnit: TimeInterval,
    tomatoPerCycle: Int,
    shortBreakUnit: TimeInterval,
    longBreakUnit: TimeInterval
  ) {
    self.index = index
    self.focusTimeUnit = focusTimeUnit
    self.tomatoPerCycle = tomatoPerCycle
    self.shortBreakUnit = shortBreakUnit
    self.longBreakUnit = longBreakUnit
  }
}


@Model
final class TagDTO {
  var id: String
  var index: Int
  var name: String
  var colorId: Int
  
  init(id: String, index: Int, name: String, colorId: Int) {
    self.id = id
    self.index = index
    self.name = name
    self.colorId = colorId
  }
}
