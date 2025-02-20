//
//  UIScreen+Extensions.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

extension UIScreen {
  static var screenWidth: CGFloat {
    UIScreen.main.bounds.width
  }
  
  static var screenHeight: CGFloat {
    UIScreen.main.bounds.height
  }
  
}

struct DynamicPadding {
  static func getHeight(_ size: CGFloat) -> CGFloat {
    return size * UIScreen.screenHeight / 874
  }
  
  static func getWidth(_ size: CGFloat) -> CGFloat {
    return size * UIScreen.screenWidth / 402
  }
}
