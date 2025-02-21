//
//  Constants.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

/// 앱 공통 상수 정의
public struct Constants {
  /// 타이머 관련 상수
  public struct Timer {
    /// 사용 가능한 타이머 색상 세트 목록
    public static let colorSets: [TimerColorSet] = [indigoSet, blueSet, cyanSet, tealSet]
    
    /// 옵션 1 색상(default 색상)
    public static let indigoSet = TimerColorSet(
      id: 0,
      normalColor: .indigoNormal,
      darkColor: .indigoDark,
      darkerColor: .indigoDarker)
    
    /// 옵션 2 색상(default 색상)
    public static let blueSet = TimerColorSet(
      id: 1,
      normalColor: .blueNormal,
      darkColor: .blueDark,
      darkerColor: .blueDarker)
    
    /// 옵션 3 색상(default 색상)
    public static let cyanSet = TimerColorSet(
      id: 2,
      normalColor: .cyanNormal,
      darkColor: .cyanDark,
      darkerColor: .cyanDarker)
    
    /// 옵션 4 색상(default 색상)
    public static let tealSet = TimerColorSet(
      id: 3,
      normalColor: .tealNormal,
      darkColor: .tealDark,
      darkerColor: .tealDarker)
    
    /// 타이머에서 사용하는 SFSymbol 정리
    public struct Symbol {
      public static let play = "play.fill"
      public static let forward = "forward.fill"
      public static let pause = "pause.fill"
      public static let stretching = "figure.cooldown"
      public static let running = "figure.run"
      public static let fullCircle = "circle.fill"
      public static let halfCircle = "circle.righthalf.filled.inverse"
      public static let emptyCircle = "circle"
      public static let checkmark = "checkmark"
    }
  }
}
