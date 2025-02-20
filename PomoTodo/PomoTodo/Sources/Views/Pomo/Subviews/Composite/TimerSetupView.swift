//
//  TimerSetupView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

struct TimerSetupView: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    VStack(alignment: .center) {
      // 상단 태그
      PomoTopView()
      Spacer().frame(height: DynamicPadding.getHeight(36))
      
      // 중앙 타이머
      PomoTimerView()
      Spacer().frame(height: DynamicPadding.getHeight(64))
      
      // 버튼
      PomoBottomView()
    } // : vstack
  }
}
