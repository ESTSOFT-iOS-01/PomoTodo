//
//  TimerRunningView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

struct TimerRunningView: View {
    // 타이머 진행...
    var tag : String

    @State var totalTime: Int
    @State var tintColor: Color
    @State var textColor: Color
    @Binding var timerActive: Bool
    
    var body: some View {
        VStack(alignment : .center) {
            Text(tag)
                .font(.pretendard(.bold, size: 18))
            Spacer().frame(height: DynamicPadding.getHeight(72))
            CircularProgressView(totalTime: $totalTime, progressColor: $tintColor, textColor: $textColor, timerActive: $timerActive, remainingTime: totalTime)
            Spacer().frame(height: DynamicPadding.getHeight(110))
            Button {
                timerActive.toggle()
            } label: {
                Image(systemName: "pause.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 36)
                    .foregroundStyle(tintColor)
            }
        }
        .onAppear {
            timerActive = true
        }
    }
}
