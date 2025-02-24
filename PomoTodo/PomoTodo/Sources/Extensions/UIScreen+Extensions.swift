//
//  UIScreen+Extensions.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

extension UIScreen {
  /// 기기 화면 너비
  static var screenWidth: CGFloat {
    UIScreen.main.bounds.width
  }
  
  /// 기기 화면 높이
  static var screenHeight: CGFloat {
    UIScreen.main.bounds.height
  }
  
}

struct DynamicPadding {
  /// 주어진 높이를 화면 비율에 맞게 변환
  static func getHeight(_ size: CGFloat) -> CGFloat {
    return size * UIScreen.screenHeight / 874
  }
  
  /// 주어진 너비를 화면 비율에 맞게 변환
  static func getWidth(_ size: CGFloat) -> CGFloat {
    return size * UIScreen.screenWidth / 402
  }
}
