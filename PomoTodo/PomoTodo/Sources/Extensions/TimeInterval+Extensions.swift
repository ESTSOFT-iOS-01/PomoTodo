//
//  TimeInterval+Extensions.swift
//  PomoTodo
//
//  Created by 도민준 on 2/19/25.
//

import Foundation

extension TimeInterval {
    func formattedTime() -> String {
        let hours = Int(self) / 3600
        let minutes = (Int(self) % 3600) / 60
        return hours > 0 ? "\(hours)h \(minutes)m" : "\(minutes)m"
    }
}
