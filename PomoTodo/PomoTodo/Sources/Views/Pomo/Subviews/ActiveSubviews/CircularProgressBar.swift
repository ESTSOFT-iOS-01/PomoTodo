//
//  CircularProgressBar.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

/// 원형 진행 바 (타이머 진행률 표시)
/// - 배경 원 (고정된 회색 원)
/// - 진행률 원 (타이머 진행 상태 표시)
struct CircularProgressBar: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    ZStack {
      /// 배경 원 (고정된 회색 원)
      Circle()
        .stroke(lineWidth: 10)
        .foregroundStyle(.timerGray)
      
      /// 진행률 원 (타이머 진행 상태 표시)
      Circle()
        .trim(from: 0.0, to: pomoVM.progress)
        .stroke(pomoVM.selectedColorSet.normal, style: StrokeStyle(lineWidth: 10, lineCap: .round))
        .rotationEffect(.degrees(-90))
        .animation(.linear(duration: 1), value: pomoVM.progress)
    }
    .frame(width: 280, height: 280)
  }
}
