//
//  PomoBottomView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

struct PomoBottomView: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    HStack(alignment: .center, spacing: DynamicPadding.getWidth(32)) {
      // 타이머 재생 버튼
      PomoActionButton(
        icon: Constants.Timer.Symbol.play,
        action: { pomoVM.send(.startTimer) },
        backgroundColor: pomoVM.selectedColorSet.normalColor
      )
      
      // 토마토/쉬는시간 넘어가기 버튼
      PomoActionButton(
        icon: Constants.Timer.Symbol.forward,
        action: { pomoVM.send(.forwardNextTimer) },
        backgroundColor: pomoVM.selectedColorSet.normalColor
      )
    } // : hstack
  }
}

struct PomoActionButton: View {
  let icon: String
  let action: () -> Void
  let backgroundColor: Color
  
  @State private var isDisabled = false
  
  var body: some View {
    Button(action: {
      guard !isDisabled else { return }
  
      isDisabled = true
      action()
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        isDisabled = false
      }
    }) {
      ZStack(alignment: .center) {
        RoundedRectangle(cornerRadius: 30)
          .foregroundStyle(backgroundColor)
          .frame(width: DynamicPadding.getWidth(128), height: DynamicPadding.getHeight(88), alignment: .center)
        
        Image(systemName: icon)
          .resizable()
          .scaledToFit()
          .foregroundStyle(.white)
          .frame(height: DynamicPadding.getHeight(24))
      }
    }
    .disabled(isDisabled) // 비활성화 상태 반영
  }
}

//#Preview {
//    PomoBottomView(backgroundColor: .tealNormal)
//}
