//
//  Constants.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

/// 앱 공통 상수 정의
public struct Constants {
  
  /// 사용 가능한 타이머 색상 세트 목록
  public enum TimerColorSet: Int, CaseIterable {
    case indigo
    case blue
    case cyan
    case teal
    
    var colors: (normal: Color, dark: Color, darker: Color) {
      switch self {
      case .indigo :
        return (.indigoNormal, .indigoDark, .indigoDarker)
      case .blue :
        return (.indigoNormal, .indigoDark, .indigoDarker)
      case .cyan :
        return (.indigoNormal, .indigoDark, .indigoDarker)
      case .teal :
        return (.indigoNormal, .indigoDark, .indigoDarker)
      }
    }
    
    var id: Int {
      return self.rawValue
    }
  }
  
  /// 타이머 관련 상수
  public struct Timer {
    /// 타이머에서 사용하는 SFSymbol 정리
    public enum Symbol: String {
      case play = "play.fill"
      case forward = "forward.fill"
      case pause = "pause.fill"
      case stretching = "figure.cooldown"
      case running = "figure.run"
      case fullCircle = "circle.fill"
      case halfCircle = "circle.righthalf.filled.inverse"
      case emptyCircle = "circle"
      case checkmark = "checkmark"
    }
  }
}
