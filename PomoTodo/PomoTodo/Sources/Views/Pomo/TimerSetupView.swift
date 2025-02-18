//
//  TimerSetupView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

struct TimerSetupView: View {
    let options: [String]
    @Binding var selectionTag: Int
    let curTomato: Int
    let totalTomato: Int
    
    let timers: [Int]
    @Binding var currentPage: Int
    @Binding var isTimerRunning : Bool
    
    var body: some View {
        VStack(alignment: .center) {
            PomoTopView(
                options: options,
                selectionTag: $selectionTag,
                curTomato: curTomato,
                totalTomato: totalTomato
            )
            Spacer().frame(height: DynamicPadding.getHeight(36))
            
            PomoTimerView(timers: timers, currentPage: $currentPage)
            Spacer().frame(height: DynamicPadding.getHeight(64))
            
            PomoBottomView(isTimerRunning: $isTimerRunning)
        }
    }
}
