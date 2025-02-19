//
//  TimerColorSet.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

public struct TimerColorSet {
    public let id: Int
    public let normalColor : Color
    public let darkColor : Color
    public let darkerColor : Color
    
    public init(id: Int, normalColor: Color, darkColor: Color, darkerColor: Color) {
        self.id = id
        self.normalColor = normalColor
        self.darkColor = darkColor
        self.darkerColor = darkerColor
    }
}
