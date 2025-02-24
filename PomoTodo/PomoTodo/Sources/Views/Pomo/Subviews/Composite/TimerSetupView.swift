//
//  TimerSetupView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

/// 타이머 설정 화면
/// - 태그 선택, 타이머 선택, 시작 버튼 등을 포함
struct TimerSetupView: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    VStack(alignment: .center) {
      /// 상단 태그 및 옵션 선택
      PomoTopView()
      Spacer().frame(height: DynamicPadding.getHeight(36))
      
      /// 중앙 타이머 설정 (페이지 컨트롤 포함)
      PomoTimerView()
      Spacer().frame(height: DynamicPadding.getHeight(64))
      
      /// 타이머 시작 및 컨트롤 버튼
      PomoBottomView()
    } // : vstack
  }
}
