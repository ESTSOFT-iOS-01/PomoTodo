//
//  TimerRunningView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

struct TimerRunningView: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    VStack(alignment: .center) {
      // 상단 태구
      TimerTagLabelView()
      Spacer().frame(height: DynamicPadding.getHeight(72))
      
      // 타이머
      CircularProgressView()
      Spacer().frame(height: DynamicPadding.getHeight(110))
      
      // 버튼
      PauseButtonView()
    } // : vstack
  }
}
