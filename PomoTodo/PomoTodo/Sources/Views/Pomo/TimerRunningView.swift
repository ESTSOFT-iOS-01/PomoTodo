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
        VStack(alignment : .center) {
            Text(pomoVM.options[pomoVM.selectionTag].name)
                .font(.pretendard(.bold, size: 18))
            Spacer().frame(height: DynamicPadding.getHeight(72))
            
            CircularProgressView()
            
            Spacer().frame(height: DynamicPadding.getHeight(110))
            Button {
                pomoVM.isTimerRunning.toggle()
            } label: {
                Image(systemName: "pause.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 36)
                    .foregroundStyle(pomoVM.selectedColorSet.normalColor)
            }
        }
        .onAppear {
            pomoVM.isTimerRunning = true
        }
    }
}
