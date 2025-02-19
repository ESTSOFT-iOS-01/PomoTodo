//
//  PomoView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

struct PomoView: View {
  
  
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
    .environmentObject(pomoVM)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .animation(.easeInOut(duration: 0.8), value: pomoVM.isTimerRunning)
    .toolbar(pomoVM.isTimerRunning ? .hidden : .visible, for: .tabBar)
  }
}

#Preview {
  PomoView()
}
