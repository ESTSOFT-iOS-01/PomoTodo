//
//  PomoView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

struct PomoView: View {
//    @State private var tabBarOpacity: Double = 1.0
    @StateObject private var pomoVM = PomoViewModel()
    
    var body: some View {
        VStack {
            if pomoVM.isTimerRunning {
                TimerRunningView()
                .transition(.scale(scale: 1.05).combined(with: .opacity))
            } else {
                TimerSetupView()
                .transition(.scale(scale: 0.95).combined(with: .opacity))
            }
            Spacer().frame(height: DynamicPadding.getHeight(40))
        } // : vstack
        .environmentObject(pomoVM)
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 🔹 부드러운 애니메이션을 위해 추가
        .animation(.easeInOut(duration: 0.8), value: pomoVM.isTimerRunning) // 🔹 애니메이션 적용
        .toolbar(pomoVM.isTimerRunning ? .hidden : .visible, for: .tabBar)
    }
}

#Preview {
    PomoView()
}

struct DummyTag: Identifiable {
    let id = UUID()
    let idx : Int
    let name: String
    let colorId : Int
    
    init(idx: Int, name: String, colorId: Int) {
        self.idx = idx
        self.name = name
        self.colorId = colorId
    }
}

struct TimerDummy : Identifiable {
    let id = UUID()
    let focusTime : Int
    let shortBreakTime : Int
    let longBreakTime : Int
    let focusCount : Int
    
    init(focusTime: Int, shortBreakTime: Int, longBreakTime: Int, focusCount: Int) {
        self.focusTime = focusTime
        self.shortBreakTime = shortBreakTime
        self.longBreakTime = longBreakTime
        self.focusCount = focusCount
    }
}
