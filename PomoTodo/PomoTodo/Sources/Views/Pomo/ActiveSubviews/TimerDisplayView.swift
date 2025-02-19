//
//  TimerDisplayView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

struct TimerDisplayView: View {
    @EnvironmentObject var pomoVM: PomoViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text(timeString(from: pomoVM.remainingTime))
                .font(.pretendard(.extraBold, size: 56))
                .frame(width: 280, alignment: .center)
                .foregroundStyle(pomoVM.selectedColorSet.darkerColor)

            Spacer().frame(height: 32)

            HStack(alignment: .center, spacing: 8) {
                tomatoIcons()
            }

            Spacer().frame(height: 62)
        }
    }

    private func timeString(from time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d : %02d", minutes, seconds)
    }

    @ViewBuilder
    private func tomatoIcons() -> some View {
        ForEach(0..<(pomoVM.curTomato - 1), id: \.self) { _ in
            Image(systemName: "circle.fill")
                .resizable()
                .foregroundColor(pomoVM.selectedColorSet.darkColor)
                .frame(width: 15, height: 15)
        }

        if pomoVM.curTomato > 0 {
            Image(systemName: "circle.righthalf.filled.inverse")
                .resizable()
                .foregroundColor(pomoVM.selectedColorSet.darkColor)
                .frame(width: 15, height: 15)
        }

        ForEach(0..<(pomoVM.totalTomato - pomoVM.curTomato), id: \.self) { _ in
            Image(systemName: "circle")
                .resizable()
                .foregroundColor(pomoVM.selectedColorSet.darkColor)
                .frame(width: 15, height: 15)
        }
    }
}

#Preview {
    TimerDisplayView()
}
