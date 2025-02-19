//
//  PomoViewModel.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

class PomoViewModel: ObservableObject {
    
    @Published var selectionTag = 0 {
        didSet {
            if oldValue != selectionTag {
                curTomato = 1
            }
        }
    }
    
    @Published var currentPage = 0 {
        didSet {
            updateTotalTime()
        }
    }
    
    @Published var currentPhase: TimerPhase = .focus {
        didSet {
            updateTotalTime()
        }
    }
    
    @Published var curTomato = 1
    @Published var totalTomato = 4
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
        TimerDummy(focusTime: 10, shortBreakTime: 15, longBreakTime: 20, focusCount: 2),
        TimerDummy(focusTime: 20, shortBreakTime: 10, longBreakTime: 30, focusCount: 4),
        TimerDummy(focusTime: 5, shortBreakTime: 2, longBreakTime: 8, focusCount: 8)
    ]
    
    var selectedColorSet: TimerColorSet {
        Constants.Timer.colorSets.first { $0.id == options[selectionTag].colorId } ?? Constants.Timer.indigoSet
    }
    
    private var timer: Timer?
    private var accumulatedFocusTime: Int = 0
    private var accumulatedTotalTime: Int = 0
    
    init() {
        updateTotalTime()
    }
    
    private func updateTotalTime() {
        let selectedTimer = timers[currentPage]
        
        switch currentPhase {
        case .focus:
            totalTime = selectedTimer.focusTime
        case .shortBreak:
            totalTime = selectedTimer.shortBreakTime
        case .longBreak:
            totalTime = selectedTimer.longBreakTime
        }
        
        remainingTime = totalTime
        progress = 1.0
    }
    
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
                self.forwardNextTimer()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        saveFocusTime()
        isTimerRunning = false
        progress = 1.0
    }
    
    func saveFocusTime() {
        if currentPhase == .focus {
            accumulatedFocusTime += (totalTime - remainingTime)
            print("집중시간 기록 : \(accumulatedFocusTime)초")
        } else {
            accumulatedTotalTime += (totalTime - remainingTime)
        }
        print("집중시간/전체시간 : \(accumulatedFocusTime)초 / \(accumulatedFocusTime + accumulatedTotalTime)")
        
    }
    
    func forwardNextTimer() {
        if currentPhase == .focus {
            if curTomato < totalTomato {
                currentPhase = .shortBreak
                totalTime = timers[currentPage].shortBreakTime
            } else {
                currentPhase = .longBreak
                totalTime = timers[currentPage].longBreakTime
            }
        } else {
            currentPhase = .focus
            totalTime = timers[currentPage].focusTime
            
            if curTomato == totalTomato {
                curTomato = 1
            } else if curTomato < totalTomato{
                curTomato += 1
            }
        }

        remainingTime = totalTime
        progress = 1.0
    }
}

enum TimerPhase {
    case focus, shortBreak, longBreak
}
