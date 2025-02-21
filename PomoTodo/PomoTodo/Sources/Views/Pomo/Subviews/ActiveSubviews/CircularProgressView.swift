//
//  CircularProgressView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

/// 원형 타이머 뷰 (타이머 진행률 및 시간 표시)
/// - 진행 바 (타이머 진행 상태 표시)
/// - 타이머 정보 (남은 시간 및 토마토 개수)
struct CircularProgressView: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    ZStack(alignment: .bottom) {
      /// 진행 바 (타이머 진행 상태 표시)
      CircularProgressBar()
      
      /// 타이머 정보 (남은 시간 및 토마토 개수)
      TimerDisplayView()
    }
  }
}
