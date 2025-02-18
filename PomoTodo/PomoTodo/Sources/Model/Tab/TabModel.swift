//
//  TabModel.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

enum Tab: Hashable {
    case Pomo, Chart, Todo, Setting
}

extension Tab {
    var labelName: String {
        switch self {
        case .Pomo: return "뽀모"
        case .Chart: return "통계"
        case .Todo: return "투두"
        case .Setting: return "설정"
        }
    }
    
    var selectedIcon: String {
        switch self {
        case .Pomo: return "clock.fill"
        case .Chart: return "chart.bar.fill"
        case .Todo: return "checklist.checked"
        case .Setting: return "gearshape.fill"
        }
    }
    
    var unselectedIcon: String {
        switch self {
        case .Pomo: return "clock"
        case .Chart: return "chart.bar"
        case .Todo: return "checklist.unchecked"
        case .Setting: return "gearshape"
        }
    }
}
