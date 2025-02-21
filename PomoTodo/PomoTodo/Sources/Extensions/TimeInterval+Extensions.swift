//
//  TimeInterval+Extensions.swift
//  PomoTodo
//
//  Created by 도민준 on 2/19/25.
//

import Foundation

extension TimeInterval {
  /// TimeInterval의 1분 (60초)
  static var minute: TimeInterval { return 60 }
  
  /// TimeInterval → Int 변환
  var asInt: Int {
    return Int(self)
  }
  
  func formattedTime() -> String {
    let hours = Int(self) / 3600
    let minutes = (Int(self) % 3600) / 60
    return hours > 0 ? "\(hours)h \(minutes)m" : "\(minutes)m"
  }

  var intMin: Int {
    get { return Int(self / .minute) }
  }
  
}
