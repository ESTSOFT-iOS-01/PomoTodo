//
//  TimerRunningInnerView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

struct TimerTagLabelView: View {
    @EnvironmentObject var pomoVM: PomoViewModel
    
    var body: some View {
        Text(pomoVM.options[pomoVM.selectionTag].name)
            .font(.pretendard(.bold, size: 18))
    }
}

struct PauseButtonView: View {
    @EnvironmentObject var pomoVM: PomoViewModel
    
    var body: some View {
        Button {
            pomoVM.stopTimer()
        } label: {
            Image(systemName: "pause.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 36)
                .foregroundStyle(pomoVM.selectedColorSet.normalColor)
        }
    }
}
