//
//  PomoTimerView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

struct PomoTimerView: View {
    let timers: [Int]
    @Binding var currentPage: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: DynamicPadding.getHeight(24)) {
            TabView(selection: $currentPage) {
                ForEach(0..<timers.count, id: \.self) { index in
                    Text(timeString(timers[currentPage]))
                        .font(.pretendard(.extraBold, size: 56))
                        .multilineTextAlignment(.center)
                        .padding()
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: 300, height: 240)
            
            PageControl(numberOfPages: timers.count, currentPage: $currentPage)
        }
    }
    
    private func timeString(_ time : Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d : %02d", minutes, seconds)
    }
}
