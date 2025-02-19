//
//  Constants.swift
//  PomoTodo
//
//  Created by 김도연 on 2/19/25.
//

import SwiftUI

public struct Constants {
    public struct Timer {
        public static let colorSets: [TimerColorSet] = [indigoSet, blueSet, cyanSet, tealSet]
        public static let indigoSet = TimerColorSet(id: 0, normalColor: .indigoNormal, darkColor: .indigoDark, darkerColor: .indigoDarker)
        public static let blueSet = TimerColorSet(id: 1, normalColor: .blueNormal, darkColor: .blueDark, darkerColor: .blueDarker)
        public static let cyanSet = TimerColorSet(id: 2, normalColor: .cyanNormal, darkColor: .cyanDark, darkerColor: .cyanDarker)
        public static let tealSet = TimerColorSet(id: 3, normalColor: .tealNormal, darkColor: .tealDark, darkerColor: .tealDarker)
    }
}

