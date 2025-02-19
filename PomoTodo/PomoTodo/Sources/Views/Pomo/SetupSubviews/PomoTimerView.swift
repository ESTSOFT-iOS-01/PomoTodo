//
//  PomoTimerView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

struct PomoTimerView: View {
    @EnvironmentObject var pomoVM: PomoViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: DynamicPadding.getHeight(24)) {
            TabView(selection: $pomoVM.currentPage) {
                ForEach(0..<pomoVM.timers.count, id: \.self) { index in
                    Text(timeString(pomoVM.timers[index].focusTime))
                        .font(.pretendard(.extraBold, size: 56))
                        .multilineTextAlignment(.center)
                        .padding()
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: 300, height: 240)
            
            PageControl(numberOfPages: pomoVM.timers.count, currentPage: $pomoVM.currentPage)
        }
    }
    
    private func timeString(_ time : Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d : %02d", minutes, seconds)
    }
}
