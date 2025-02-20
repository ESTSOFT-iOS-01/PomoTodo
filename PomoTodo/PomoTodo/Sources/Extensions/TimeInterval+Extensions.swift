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
  
  /// 초를 Int 분으로 변경
  var intMin: Int {
    get { return Int(self / .minute) }
  }
  
func formattedTime() -> String {
  let hours = Int(self) / 3600
  let minutes = (Int(self) % 3600) / 60
  return hours > 0 ? "\(hours)h \(minutes)m" : "\(minutes)m"
  }
}
