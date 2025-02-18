//
//  CircularProgressView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

struct CircularProgressView: View {
    @Binding var totalTime: Int
    @Binding var progressColor: Color
    @Binding var textColor: Color
    @Binding var timerActive: Bool
    
    @State var remainingTime: Int // 남은 시간 (초)
    @State private var progress: CGFloat = 1.0
    
    
    let curTomato: Int = 3
    let totalTomato: Int = 6
    var tomatoColor: Color = .indigoDark
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack() {
                Circle()
                    .stroke(lineWidth: 10)
                    .foregroundStyle(.timerGray)
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(progressColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 1), value: progress)
            }
            .frame(width: 280, height: 280)
            
            VStack(alignment: .center) {
                Text(timeString())
                    .font(.pretendard(.extraBold, size: 56))
                    .frame(width: 280, alignment: .center)
                    .foregroundStyle(textColor)
                Spacer().frame(height: 32)
                HStack(alignment: .center, spacing: 8) {
                    tomatoIcons()
                }
                Spacer().frame(height: 62)
            }
        }
        .onAppear {
            remainingTime = totalTime // 초기값 설정
            if timerActive {
                startTimer()
            }
        }
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if remainingTime > 0 {
                remainingTime -= 1
                progress = CGFloat(remainingTime) / CGFloat(totalTime)
            } else {
                timer.invalidate()
                timerActive = false
            }
        }
    }
    
    private func timeString() -> String {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        return String(format: "%02d : %02d", minutes, seconds)
    }
    
    @ViewBuilder
    private func tomatoIcons() -> some View {
        ForEach(0..<(curTomato - 1), id: \.self) { _ in
            Image(systemName: "circle.fill")
                .resizable()
                .foregroundColor(tomatoColor)
                .frame(width: 15, height: 15)
        }
        
        if curTomato > 0 {
            Image(systemName: "circle.righthalf.filled.inverse")
                .resizable()
                .foregroundColor(tomatoColor)
                .frame(width: 15, height: 15)
        }
        
        ForEach(0..<(totalTomato - curTomato), id: \.self) { _ in
            Image(systemName: "circle")
                .resizable()
                .foregroundColor(tomatoColor)
                .frame(width: 15, height: 15)
        }
    }
    
}

//#Preview {
//    CircularProgressView(totalTime: .constant(6000), progressColor: .constant(.indigoNormal), textColor: .constant(.indigoDarker), remainingTime: 1500)
//}
