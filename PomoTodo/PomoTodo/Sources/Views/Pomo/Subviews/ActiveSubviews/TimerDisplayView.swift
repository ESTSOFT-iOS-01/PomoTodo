//
//  TimerDisplayView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

/// 타이머 정보 뷰 (남은 시간 및 토마토 진행 상태)
/// - 디지털 시계 스타일로 남은 시간 표시
/// - 현재 사이클 진행 상태를 아이콘으로 표시
struct TimerDisplayView: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    VStack(alignment: .center) {
      /// 남은 시간 표시
      Text(pomoVM.remainingTime.asTimeString)
        .monospacedDigit()
        .font(.pretendard(.extraBold, size: 56))
        .frame(width: 280, alignment: .center)
        .foregroundStyle(pomoVM.selectedColorSet.darker)
      
      Spacer().frame(height: 32)
      
      /// 토마토 진행 상태 아이콘
      HStack(alignment: .center, spacing: 8) {
        tomatoIcons()
      }
      
      Spacer().frame(height: 62)
    } // : vstack
  }
  
  // MARK: - UI Helper Methods
    
  /// 토마토 진행 상태 아이콘 표시
  @ViewBuilder
  private func tomatoIcons() -> some View {
    ForEach(0..<(pomoVM.curTomato - 1), id: \.self) { _ in
      createTomatoIcon(systemName: Constants.Timer.Symbol.fullCircle.rawValue)
    }
    
    if pomoVM.curTomato > 0 {
      createTomatoIcon(systemName: Constants.Timer.Symbol.halfCircle.rawValue)
    }
    
    ForEach(0..<(pomoVM.totalTomato - pomoVM.curTomato), id: \.self) { _ in
      createTomatoIcon(systemName: Constants.Timer.Symbol.emptyCircle.rawValue)
    }
  }
  
  /// 토마토 아이콘 생성 (색상 및 크기 통일)
  @ViewBuilder
  private func createTomatoIcon(systemName: String) -> some View {
    Image(systemName: systemName)
      .resizable()
      .scaledToFit()
      .foregroundColor(pomoVM.selectedColorSet.dark)
      .frame(height: 15)
  }
}
