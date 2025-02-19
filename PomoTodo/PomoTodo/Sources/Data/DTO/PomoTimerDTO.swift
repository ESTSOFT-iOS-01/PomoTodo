//
//  PomoTimerDTO.swift
//  PomoTodo
//
//  Created by 신승재 on 2/18/25.
//

import Foundation
import SwiftData

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
  
  convenience init(_ data: PomoTimer) {
    self.init(
      index: data.index,
      focusTimeUnit: data.focusTimeUnit,
      tomatoPerCycle: data.tomatoPerCycle,
      shortBreakUnit: data.shortBreakUnit,
      longBreakUnit: data.longBreakUnit
    )
  }
}

extension PomoTimerDTO {
  func toEntity() -> PomoTimer {
    PomoTimer(
      index: self.index,
      focusTimeUnit: self.focusTimeUnit,
      tomatoPerCycle: self.tomatoPerCycle,
      shortBreakUnit: self.shortBreakUnit,
      longBreakUnit: self.longBreakUnit
    )
  }
}
