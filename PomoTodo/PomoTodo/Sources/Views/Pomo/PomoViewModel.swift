//
//  PomoViewModel.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

final class PomoViewModel: ObservableObject {
  // MARK: - UI 변수
  /// 태그 관련
  @Published var options: [Tag]
  @Published var selectionTag = 0 {
    didSet {
      if oldValue != selectionTag {
        changeColorSet()
        resetCycle()
      }
    }
  }
  
  /// 타이머 세트 관련
  @Published var timers: [PomoTimer]
  @Published var currentPage = 0 {
    didSet {
      updateTotalTime()
      if oldValue != currentPage {
        resetCycle()
      }
    }
  }
  
  var selectedColorSet: TimerColorSet = Constants.Timer.indigoSet
  
  /// 현재 타이머 상태 관련
  @Published var curTomato = 1
  @Published var totalTomato = 2
  @Published var currentPhase: TimerPhase = .focus {
    didSet {
      updateTotalTime()
    }
  }
  
  @Published var isTimerRunning = false
  @Published var progress: CGFloat = 1.0
  
  @Published var totalTime: Int = 10
  @Published var remainingTime: Int = 10
  
  // MARK: - Action Case 정의
  enum pomoAction {
    case onAppear
    case startTimer
    case stopTimer
    case forwardNextTimer
  }
  
  // MARK: - Private 변수: 데이터 관련
  private var pomoTodoUseCase: PomoTodoUseCase

  private var timer: Timer?
  private var accumulatedFocusTime: Int = 0
  private var accumulatedTotalTime: Int = 0
  
  // MARK: - Initialization
  init (pomoTodoUseCase: PomoTodoUseCase) {
    self.pomoTodoUseCase = pomoTodoUseCase
    self.options = pomoTodoUseCase.getAppConfig().tags
    self.timers = pomoTodoUseCase.getAppConfig().pomoTimers
  }
  
  // MARK: - Actions
  func send(_ action: pomoAction) {
    switch action {
    case .onAppear:
      setUI()
    case .startTimer:
      startTimer()
    case .stopTimer:
      stopTimer()
    case .forwardNextTimer:
      forwardNextTimer()
    }
  }
  
  // MARK: - Action Funcs
  func setUI() {
    self.options = pomoTodoUseCase.getAppConfig().tags
    self.timers = pomoTodoUseCase.getAppConfig().pomoTimers
    
    updateTotalTime()
    changeColorSet()
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
        // 한 토마토에 해당하는 사이클 퍼센트 저장
        saveFocusTomato()
        self.stopTimer() // 타이머 종료
        
        self.triggerHapticFeedback()
        self.forwardNextTimer()
      }
    }
  }
  
  func stopTimer() {
    timer?.invalidate()
    saveFocusTime() // 시간 기록(토마토 완성 여부와 무관)
    isTimerRunning = false
    progress = 1.0
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
  
}

extension PomoViewModel {
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
  
  private func triggerHapticFeedback() {
      let generator = UINotificationFeedbackGenerator()
      generator.notificationOccurred(.success)
  }
  
  private func resetCycle() {
    curTomato = 1 // 암튼 무조건 세션 초기화
  }
  
  private func changeColorSet() {
    selectedColorSet = Constants.Timer.colorSets.first { $0.id == options[selectionTag].colorId } ?? Constants.Timer.indigoSet
  }
  
  // MARK: - Data Funcs
  // 집중 시간이랑 전체 시간(집중 + 휴식) 저장
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
