//
//  PomoViewModel.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

class PomoViewModel: ObservableObject {
    @Published var selectionTag = 0
    @Published var curTomato = 1
    @Published var totalTomato = 4
    @Published var currentPage = 0
    @Published var isTimerRunning = false
    
    @Published var totalTime: Int = 1500
    @Published var remainingTime: Int = 1500
    @Published var progress: CGFloat = 1.0
    
    @Published var options: [DummyTag] = [
        DummyTag(idx: 0, name: "옵션 1", colorId: 0),
        DummyTag(idx: 1, name: "옵션 2", colorId: 1),
        DummyTag(idx: 2, name: "옵션 3", colorId: 2),
        DummyTag(idx: 3, name: "옵션 4", colorId: 3)
    ]
    
    @Published var timers: [TimerDummy] = [
        TimerDummy(focusTime: 100, shortBreakTime: 60, longBreakTime: 120, focusCount: 4),
        TimerDummy(focusTime: 2000, shortBreakTime: 60, longBreakTime: 120, focusCount: 6),
        TimerDummy(focusTime: 3000, shortBreakTime: 60, longBreakTime: 120, focusCount: 8)
    ]
    
    var selectedColorSet: TimerColorSet {
        Constants.Timer.colorSets.first { $0.id == options[selectionTag].colorId } ?? Constants.Timer.indigoSet
    }
    
    private var timer: Timer?
    
    func startTimer() {
        isTimerRunning = true
        remainingTime = totalTime
        progress = 1.0
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            if self.remainingTime > 0 {
                self.remainingTime -= 1
                self.progress = CGFloat(self.remainingTime) / CGFloat(self.totalTime)
            } else {
                self.stopTimer()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        isTimerRunning = false
        progress = 1.0
    }
}
