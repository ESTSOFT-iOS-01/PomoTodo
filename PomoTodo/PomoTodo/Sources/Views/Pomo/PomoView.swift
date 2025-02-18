//
//  PomoView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

struct PomoView: View {
    // dummy datas
    var options = ["취미", "짧은 옵션", "중간 길이의 옵션", "정말 길~~~~~~~~~~~~~어 보이는 선택 옵션"]
    let timers = [100, 2000, 4000]
    
    @State private var isTimerRunning = false
    @State private var tabBarOpacity: Double = 1.0
    
    @State private var selectionTag = 0
    @State private var curTomato = 3
    @State private var totalTomato = 6
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            if isTimerRunning {
                TimerRunningView(
                    tag: options[selectionTag],
                    totalTime: timers[currentPage],
                    tintColor: .indigoNormal,
                    textColor: .indigoDarker,
                    timerActive: $isTimerRunning
                )
                .transition(.scale(scale: 1.05).combined(with: .opacity))
            } else {
                TimerSetupView(
                    options: options,
                    selectionTag: $selectionTag,
                    curTomato: curTomato,
                    totalTomato: totalTomato,
                    timers: timers,
                    currentPage: $currentPage,
                    isTimerRunning: $isTimerRunning
                )
                .transition(.scale(scale: 0.95).combined(with: .opacity))
            }
            Spacer().frame(height: DynamicPadding.getHeight(40))
        } // : vstack
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 🔹 부드러운 애니메이션을 위해 추가
        .animation(.easeInOut(duration: 0.8), value: isTimerRunning) // 🔹 애니메이션 적용
        .toolbar(isTimerRunning ? .hidden : .visible, for: .tabBar)
    }
}

#Preview {
    PomoView()
}
