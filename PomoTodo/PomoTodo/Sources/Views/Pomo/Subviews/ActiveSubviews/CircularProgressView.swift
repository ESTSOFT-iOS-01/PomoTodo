//
//  CircularProgressView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

struct CircularProgressView: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    // 여기는 사이즈 조절 없이
    ZStack(alignment: .bottom) {
      // progress bar
      CircularProgressBar()
      
      // Texts
      TimerDisplayView()
    }
  }
}
