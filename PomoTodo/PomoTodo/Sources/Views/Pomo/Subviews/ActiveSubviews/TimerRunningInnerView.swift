//
//  TimerRunningInnerView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

/// **현재 선택된 태그 라벨 뷰**
/// - 포커스 상태일 때는 태그명만 표시
/// - 휴식 시간일 때는 아이콘과 함께 표시
struct TimerTagLabelView: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    HStack(alignment: .bottom) {
      if pomoVM.currentPhase != .focus {
        Image(systemName: Constants.Timer.Symbol.stretching)
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

/// **타이머 정지(일시정지) 버튼**
/// - 버튼을 누르면 타이머를 멈춤
struct PauseButtonView: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    Button {
      pomoVM.send(.stopTimer)
    } label: {
      Image(systemName: Constants.Timer.Symbol.pause)
        .resizable()
        .scaledToFit()
        .frame(height: 36)
        .foregroundStyle(pomoVM.selectedColorSet.normalColor)
    }
  }
}
