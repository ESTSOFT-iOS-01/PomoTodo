//
//  TimerRunningView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

/// 타이머 진행 화면
/// - 현재 진행 중인 태그
/// - 원형 타이머
/// - 일시정지 버튼
struct TimerRunningView: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    VStack(alignment: .center) {
      /// 현재 진행 중인 태그 표시
      TimerTagLabelView()
      Spacer().frame(height: DynamicPadding.getHeight(72))
      
      /// 원형 타이머 뷰
      CircularProgressView()
      Spacer().frame(height: DynamicPadding.getHeight(110))
      
      /// 일시정지 버튼
      PauseButtonView()
    } // : vstack
  }
}
