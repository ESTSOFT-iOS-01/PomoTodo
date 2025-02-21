//
//  PomoView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

/// **포모도로 타이머 메인 뷰**
/// - 타이머 실행 여부에 따라 `TimerSetupView` 또는 `TimerRunningView` 전환
/// - 애니메이션 효과 적용 및 `TabBar` 가시성 조절
struct PomoView: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    VStack {
      if pomoVM.isTimerRunning {
        TimerRunningView()
          .transition(.scale(scale: 1.05).combined(with: .opacity))
      } else {
        TimerSetupView()
          .transition(.scale(scale: 0.95).combined(with: .opacity))
      }
      Spacer().frame(height: DynamicPadding.getHeight(40))
    } // : vstack
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .animation(.easeInOut(duration: 0.8), value: pomoVM.isTimerRunning)
    .toolbar(pomoVM.isTimerRunning ? .hidden : .visible, for: .tabBar)
    .onAppear {
      pomoVM.send(.onAppear)
    }
  }
}

#Preview {
  PomoView()
}
