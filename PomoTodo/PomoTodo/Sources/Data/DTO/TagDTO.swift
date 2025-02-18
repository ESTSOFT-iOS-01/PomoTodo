//
//  TagDTO.swift
//  PomoTodo
//
//  Created by 신승재 on 2/18/25.
//

import Foundation
import SwiftData

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
  
  convenience init(_ data: Tag) {
    self.init(
      id: data.id,
      index: data.index,
      name: data.name,
      colorId: data.colorId
    )
  }
}

extension TagDTO {
  func toEntity() -> Tag {
    return Tag(
      id: self.id,
      index: self.index,
      name: self.name,
      colorId: self.colorId
    )
  }
}
