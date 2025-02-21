//
//  PomoTimerView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

/// **타이머 설정 및 페이지 컨트롤 UI**
/// - `TabView`를 이용한 타이머 설정
/// - 현재 `currentPhase`에 맞는 시간 표시
/// - `PageControl`과 연동하여 타이머 선택 가능
struct PomoTimerView: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    VStack(alignment: .center, spacing: DynamicPadding.getHeight(24)) {
      /// 타이머 선택 페이지
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
  
  // MARK: - UI Helper Methods
  /// **타이머 텍스트 뷰 생성**
  /// - 현재 `currentPhase`에 따라 적절한 시간을 표시
  @ViewBuilder
  private func timerText(for timer: PomoTimer) -> some View {
    Text(timeForPhase(timer).asTimeString)
      .font(.pretendard(.extraBold, size: 56))
      .multilineTextAlignment(.center)
      .padding()
  }
  
  /// **현재 Phase에 맞는 시간 반환**
  /// - `currentPhase`에 따라 포커스/쉬는 시간 값 선택
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
  
}
