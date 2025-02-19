//
//  CircularProgressBar.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

struct CircularProgressBar: View {
    @EnvironmentObject var pomoVM: PomoViewModel

    var body: some View {
        ZStack {
            // background Circle
            Circle()
                .stroke(lineWidth: 10)
                .foregroundStyle(.timerGray)
            
            // progress Circle
            Circle()
                .trim(from: 0.0, to: pomoVM.progress)
                .stroke(pomoVM.selectedColorSet.normalColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 1), value: pomoVM.progress)
        }
        .frame(width: 280, height: 280)
    }
}

//#Preview {
//    CircularProgressBar()
//}
