//
//  Int+Extensions.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import Foundation

extension Int {
  /// Int → Double 변환
  var asDouble: Double {
    return Double(self)
  }
  
  /// 시간을 "MM:SS" 형태의 문자열로 변환
  var asTimeString: String {
    let minutes = self / 60
    let seconds = self % 60
    return String(format: "%02d : %02d", minutes, seconds)
  }
}
