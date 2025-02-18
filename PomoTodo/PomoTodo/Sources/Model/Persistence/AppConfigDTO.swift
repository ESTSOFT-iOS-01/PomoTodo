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
  
  convenience init(_ data: AppConfig) {
    self.init(
      pomoTimers: data.pomoTimers.map { PomoTimerDTO($0) },
      tags: data.tags.map { TagDTO($0) }
    )
  }
}

extension AppConfigDTO {
  func toEntity() -> AppConfig {
    return AppConfig(
      pomoTimers: self.pomoTimers
        .map { $0.toEntity() }
        .sorted { $0.index < $1.index },
      tags: self.tags
        .map { $0.toEntity() }
        .sorted { $0.index < $1.index }
      )
  }
}
