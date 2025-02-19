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
        saveTomatoProgress()
        curTomato = 1
        completedTomatoes = 0
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
  @Published var completedTomatoes = 0
  @Published var isTimerRunning = false
  
  @Published var totalTime: Int = 1500
  @Published var remainingTime: Int = 1500
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
        // 타이머 종료
        self.stopTimer()
        self.forwardNextTimer(true) // 완벽한 토마토 한 개 완성
      }
    }
  }
  
  // 타이머 멈춤
  func stopTimer() {
    timer?.invalidate()
    saveFocusTime() // 시간 기록
    isTimerRunning = false
    progress = 1.0
  }
  
  func forwardNextTimer(_ isEnd : Bool = false) {
    if currentPhase == .focus {
      if curTomato < totalTomato {
        currentPhase = .shortBreak
        totalTime = timers[currentPage].shortBreakUnit.asInt
        currentPhase = .longBreak
        totalTime = timers[currentPage].longBreakUnit.asInt
      }
      
      if isEnd {
        completedTomatoes += 1
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
  
  //MARK: - Data Funcs
  // 집중 시간 이랑 전체 시간(집중 + 휴식) 저장
  func saveFocusTime() {
    if currentPhase == .focus {
      accumulatedFocusTime += (totalTime - remainingTime)
    } else {
      accumulatedTotalTime += (totalTime - remainingTime)
    }
    print("\(options[selectionTag].name)의 집중시간/전체시간 : \(accumulatedFocusTime)초 / \(accumulatedFocusTime + accumulatedTotalTime)")
    
  }
  
  // 완성한 토마토 개수 랑 단위 토마토 개수 저장
  func saveTomatoProgress() {
    print("🍅 완료된 토마토 개수: \(completedTomatoes) / 단위 토마토 개수: \(totalTomato)")
  }
  
}
