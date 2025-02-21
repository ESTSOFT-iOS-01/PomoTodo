//
//  PomoViewModel.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

/// **포모도로 타이머의 ViewModel**
/// - 타이머 설정, 상태 변경, 데이터 저장 및 UI 업데이트 관리
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
  
  /// 현재 선택된 컬러 세트
  var selectedColorSet: TimerColorSet = Constants.Timer.indigoSet
  
  /// 타이머 진행 상태 관련 변수
  @Published var curTomato = 1
  @Published var totalTomato = 2
  @Published var currentPhase: TimerPhase = .focus {
    didSet {
      updateTotalTime()
    }
  }
  
  @Published var isTimerRunning = false
  @Published var progress: CGFloat = 1.0
  
  /// 현재 진행 중인 타이머의 총 시간
  @Published var totalTime: Int = 10
  @Published var remainingTime: Int = 10
  
  // MARK: - Action Case 정의
  /// **포모도로 타이머에서 발생할 수 있는 이벤트**
  enum pomoAction {
    case onAppear
    case startTimer
    case stopTimer
    case forwardNextTimer
  }
  
  // MARK: - internal 변수: 데이터 관련
  internal var pomoTodoUseCase: PomoTodoUseCase

  internal var timer: Timer?
  internal var accumulatedFocusTime: Int = 0
  internal var accumulatedTotalTime: Int = 0
  
  // MARK: - Initialization
  
  /// **포모도로 타이머 뷰모델 초기화**
  /// - `pomoTodoUseCase`: 포모도로 데이터 관리 유즈케이스
  init (pomoTodoUseCase: PomoTodoUseCase) {
    self.pomoTodoUseCase = pomoTodoUseCase
    self.options = pomoTodoUseCase.getAppConfig().tags
    self.timers = pomoTodoUseCase.getAppConfig().pomoTimers
  }
  
  // MARK: - Actions
  
  /// **이벤트 핸들러**
  /// - `action`: 수행할 액션 (`pomoAction` 타입)
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
  
  /// **UI 초기 설정**
  func setUI() {
    self.options = pomoTodoUseCase.getAppConfig().tags
    self.timers = pomoTodoUseCase.getAppConfig().pomoTimers
    
    updateTotalTime()
    changeColorSet()
  }
  
  /// **타이머 시작**
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
  
  /// **타이머 중지**
  func stopTimer() {
    timer?.invalidate()
    saveFocusTime() // 시간 기록(토마토 완성 여부와 무관)
    isTimerRunning = false
    progress = 1.0
  }
  
  /// **다음 타이머 세션으로 이동**
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

