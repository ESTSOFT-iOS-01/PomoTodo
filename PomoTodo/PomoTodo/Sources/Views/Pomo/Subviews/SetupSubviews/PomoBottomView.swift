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
        icon: "play.fill",
        action: { pomoVM.startTimer() },
        backgroundColor: pomoVM.selectedColorSet.normalColor
      )
      
      // 토마토/쉬는시간 넘어가기 버튼
      PomoActionButton(
        icon: "forward.fill",
        action: { pomoVM.forwardNextTimer() },
        backgroundColor: pomoVM.selectedColorSet.normalColor
      )
    } // : hstack
  }
}

struct PomoActionButton: View {
  let icon: String
  let action: () -> Void
  let backgroundColor: Color
  
  var body: some View {
    Button(action: action) {
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
  }
}

//#Preview {
//    PomoBottomView(backgroundColor: .tealNormal)
//}
