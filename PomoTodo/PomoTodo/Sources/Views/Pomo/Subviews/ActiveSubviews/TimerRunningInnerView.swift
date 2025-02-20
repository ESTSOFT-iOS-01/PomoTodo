//
//  TimerRunningInnerView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

struct TimerTagLabelView: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    HStack(alignment: .bottom) {
      // 휴식 시간일 때만, 아이콘 표시
      if pomoVM.currentPhase != .focus {
        Image(systemName: "figure.cooldown")
          .resizable()
          .scaledToFit()
          .frame(height: 24, alignment: .center)
        Spacer().frame(width: 12)
      }
      
      Text(pomoVM.options[pomoVM.selectionTag].name)
        .font(.pretendard(.bold, size: 18))
    }
    
  }
}

struct PauseButtonView: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    Button {
      pomoVM.stopTimer()
    } label: {
      Image(systemName: "pause.fill")
        .resizable()
        .scaledToFit()
        .frame(height: 36)
        .foregroundStyle(pomoVM.selectedColorSet.normalColor)
    }
  }
}

#Preview{
  TimerTagLabelView()
    .environmentObject(PomoViewModel(pomoTodoUseCase: DIContainer().pomoTodoUseCase))
}
