//
//  PomoViewModelSetting.swift
//  PomoTodo
//
//  Created by 심근웅 on 2/19/25.
//

import Foundation
import SwiftUI
import Combine

class PomoViewModelSetting: ObservableObject {
  @Published var options: [Tag] = [
    Tag(index: 0, name: "공부", colorId: 0),
    Tag(index: 1, name: "취미", colorId: 1),
    Tag(index: 2, name: "독서", colorId: 2),
    Tag(index: 3, name: "운동", colorId: 3)
  ]
  @Published var timers: [PomoTimer] = [
    PomoTimer(index: 0, focusTimeUnit: 25*60, tomatoPerCycle: 6, shortBreakUnit: 1*60, longBreakUnit: 30*60),
    PomoTimer(index: 1, focusTimeUnit: 5*60, tomatoPerCycle: 8, shortBreakUnit: 1*60, longBreakUnit: 15*60),
    PomoTimer(index: 2, focusTimeUnit: 60*60, tomatoPerCycle: 4, shortBreakUnit: 1*60, longBreakUnit: 60*60)
  ]
  @Published var pomoName: [String] = ["기본 뽀모도로","짧은 뽀모도로","긴 뽀모도로"]
  
  func optionsSave() {
    print("options의 값을 디비에 저장")
    // 태그 편집버튼 완료 클릭 시 실행
  }
  func timerSave() {
    print("timers에 있는 값을 디비에 저장")
    // 각 뽀모도로의 속성을 변경완료 시 실행
    // 빈 공간 클릭 시 실행되지 않음
  }
  func viewModelLoad(){
    print("디비에서 options와 timers의 정보를 불러옴")
    // 아마 설정을 들어올때 한번 로드
  }
}


