//
//  PomoTimerView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

struct PomoTimerView: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    VStack(alignment: .center, spacing: DynamicPadding.getHeight(24)) {
      TabView(selection: $pomoVM.currentPage) {
        ForEach(0..<pomoVM.timers.count, id: \.self) { index in
          timerText(for: pomoVM.timers[index])
            .tag(index)
        }
      }
      .tabViewStyle(.page(indexDisplayMode: .never))
      .frame(width: 300, height: 240)
      
      PageControl()
    }
  }
  
  //MARK: - UI setting funcs
  
  @ViewBuilder
  private func timerText(for timer: PomoTimer) -> some View {
    Text(formatTime(timeForPhase(timer)))
      .font(.pretendard(.extraBold, size: 56))
      .multilineTextAlignment(.center)
      .padding()
  }
  
  private func timeForPhase(_ timer: PomoTimer) -> Int {
    switch pomoVM.currentPhase {
    case .focus:
      return timer.focusTimeUnit.asInt
    case .shortBreak:
      return timer.shortBreakUnit.asInt
    case .longBreak:
      return timer.longBreakUnit.asInt
      
    }
  }
  
  private func formatTime(_ time: Int) -> String {
    let minutes = time / 60
    let seconds = time % 60
    return String(format: "%02d : %02d", minutes, seconds)
  }
}
