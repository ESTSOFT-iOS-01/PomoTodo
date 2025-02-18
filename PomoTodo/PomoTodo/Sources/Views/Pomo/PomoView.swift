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
    let timers = ["25 : 00", "40 : 00", "50 : 00" ]
    
    @State private var isTimerRunning = false
    
    @State private var selectionTag = 0
    @State private var curTomato = 1
    @State private var totalTomato = 4
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            if isTimerRunning {
                
            } else {
                TimerSetupView(options: options, selectionTag: $selectionTag, curTomato: curTomato, totalTomato: totalTomato, timers: timers, currentPage: $currentPage) {
                    isTimerRunning = true
                }
            }
        }
        Spacer().frame(height: DynamicPadding.getHeight(60))
    }
}

#Preview {
    PomoView()
}
