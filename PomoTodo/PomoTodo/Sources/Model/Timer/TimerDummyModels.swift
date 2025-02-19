//
//  TimerDummyModels.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import Foundation

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
