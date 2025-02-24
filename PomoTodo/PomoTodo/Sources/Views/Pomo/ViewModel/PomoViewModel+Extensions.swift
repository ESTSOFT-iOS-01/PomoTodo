//
//  PomoViewModel+Extensions.swift
//  PomoTodo
//
//  Created by 김도연 on 2/21/25.
//

import SwiftUI

extension PomoViewModel {
  /// **현재 선택된 타이머 정보를 기반으로 총 시간 업데이트**
  internal func updateTotalTime() {
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
  
  /// **햅틱 피드백 발생**
  internal func triggerHapticFeedback() {
      let generator = UINotificationFeedbackGenerator()
      generator.notificationOccurred(.success)
  }
  
  /// **포모도로 세션 초기화**
  internal func resetCycle() {
    curTomato = 1 // 암튼 무조건 세션 초기화
  }
  
  /// **선택한 태그에 맞는 컬러 세트 변경**
  internal func changeColorSet() {
    selectedColorSet = Constants.TimerColorSet(rawValue: options[selectionTag].colorId)?.colors ?? Constants.TimerColorSet(rawValue: 0)!.colors
  }
  
  // MARK: - Data Funcs
  /// **사용자의 집중 시간 저장**
  internal func saveFocusTime() {
    if currentPhase == .focus {
      accumulatedFocusTime += (totalTime - remainingTime)
      pomoTodoUseCase.addTagTimeRecords(todayPomoDay: pomoTodoUseCase.getTodayPomoDay(), tagTimeRecord: TagTimeRecord(tagId: options[selectionTag].id, focusTime: accumulatedFocusTime.asDouble))
      accumulatedFocusTime = 0
    } else {
      accumulatedTotalTime += (totalTime - remainingTime)
    }
  }
  
  /// **완료된 토마토 개수 및 사이클 저장**
  internal func saveFocusTomato() {
    if currentPhase == .focus {
      pomoTodoUseCase.updateTomatoAndCycle(todayPomoDay: pomoTodoUseCase.getTodayPomoDay(), tomatoCnt: 1, cycleCnt: 1 / totalTomato.asDouble)
    }
  }
}
