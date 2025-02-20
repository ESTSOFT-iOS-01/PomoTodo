//
//  PomoViewModel.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

final class PomoViewModel: ObservableObject {
  private var pomoTodoUseCase: PomoTodoUseCase
  
  @Published var selectionTag = 0 {
    didSet {
      if oldValue != selectionTag {
        resetCycle()
      }
    }
  }
  
  @Published var currentPage = 0 {
    didSet {
      updateTotalTime()
      if oldValue != currentPage {
        resetCycle()
      }
    }
  }
  
  @Published var currentPhase: TimerPhase = .focus {
    didSet {
      updateTotalTime()
    }
  }
  
  @Published var curTomato = 1
  @Published var totalTomato = 2
  @Published var isTimerRunning = false
  
  @Published var totalTime: Int = 10
  @Published var remainingTime: Int = 10
  @Published var progress: CGFloat = 1.0
  
  @Published var options: [Tag]
  @Published var timers: [PomoTimer]
  
  var selectedColorSet: TimerColorSet {
    Constants.Timer.colorSets.first { $0.id == options[selectionTag].colorId } ?? Constants.Timer.indigoSet
  }
  
  private var timer: Timer?
  private var accumulatedFocusTime: Int = 0
  private var accumulatedTotalTime: Int = 0
  
  //MARK: - UI Funcs
  init (pomoTodoUseCase: PomoTodoUseCase) {
    // 데이터 세팅
    self.pomoTodoUseCase = pomoTodoUseCase
    self.options = pomoTodoUseCase.getAppConfig().tags
    self.timers = pomoTodoUseCase.getAppConfig().pomoTimers
    
    updateTotalTime()
  }
  
  private func updateTotalTime() {
    let selectedTimer = timers[currentPage]
    
    switch currentPhase {
    case .focus:
      totalTime = selectedTimer.focusTimeUnit.asInt
    case .shortBreak:
      totalTime = selectedTimer.shortBreakUnit.asInt
    case .longBreak:
      totalTime = selectedTimer.longBreakUnit.asInt
    }
    
    remainingTime = totalTime
    totalTomato = selectedTimer.tomatoPerCycle
    progress = 1.0
  }
  
  //MARK: - Action Funcs
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
        // 한 토마토에 해당하는 사이클 퍼센트 저장
        saveFocusTomato()
        self.stopTimer() // 타이머 종료
        
        self.triggerHapticFeedback()
        self.forwardNextTimer()
      }
    }
  }
  
  // 타이머 멈춤
  func stopTimer() {
    timer?.invalidate()
    saveFocusTime() // 시간 기록(토마토 완성 여부와 무관)
    isTimerRunning = false
    progress = 1.0
    print(pomoTodoUseCase.getTodayPomoDay())
  }
  
  func forwardNextTimer() {
    if currentPhase == .focus {
      if curTomato < totalTomato {
        currentPhase = .shortBreak
        totalTime = timers[currentPage].shortBreakUnit.asInt
      } else {
        currentPhase = .longBreak
        totalTime = timers[currentPage].longBreakUnit.asInt
      }
    } else {
      currentPhase = .focus
      totalTime = timers[currentPage].focusTimeUnit.asInt
      
      if curTomato == totalTomato {
        curTomato = 1
      } else if curTomato < totalTomato{
        curTomato += 1
      }
    }
    
    remainingTime = totalTime
    progress = 1.0
  }
  
  private func triggerHapticFeedback() {
      let generator = UINotificationFeedbackGenerator()
      generator.notificationOccurred(.success)
  }
  
  private func resetCycle() {
    curTomato = 1 // 암튼 무조건 세션 초기화
  }
  
  //MARK: - Data Funcs
  // 집중 시간 이랑 전체 시간(집중 + 휴식) 저장
  private func saveFocusTime() {
    if currentPhase == .focus {
      accumulatedFocusTime += (totalTime - remainingTime)
      pomoTodoUseCase.addTagTimeRecords(todayPomoDay: pomoTodoUseCase.getTodayPomoDay(), tagTimeRecord: TagTimeRecord(tagId: options[selectionTag].id, focusTime: accumulatedFocusTime.asTimeInterval))
      accumulatedFocusTime = 0
    } else {
      accumulatedTotalTime += (totalTime - remainingTime)
    }
  }
  
  private func saveFocusTomato() {
    if currentPhase == .focus {
      pomoTodoUseCase.updateTomatoAndCycle(todayPomoDay: pomoTodoUseCase.getTodayPomoDay(), tomatoCnt: 1, cycleCnt: 1 / totalTomato.asDouble)
    }
  }
  
}
