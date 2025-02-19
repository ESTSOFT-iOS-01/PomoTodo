//
//  TagTimeRecordDTO.swift
//  PomoTodo
//
//  Created by 신승재 on 2/18/25.
//

import Foundation
import SwiftData

@Model
final class TagTimeRecordDTO {
  var tagId: String
  var focusTime: TimeInterval
  
  init(tagId: String, focusTime: TimeInterval) {
    self.tagId = tagId
    self.focusTime = focusTime
  }
  
  convenience init(_ data: TagTimeRecord) {
    self.init(
      tagId: data.tagId,
      focusTime: data.focusTime
    )
  }
}

extension TagTimeRecordDTO {
  func toEntity() -> TagTimeRecord {
    return TagTimeRecord(
      tagId: self.tagId,
      focusTime: self.focusTime
    )
  }
}
