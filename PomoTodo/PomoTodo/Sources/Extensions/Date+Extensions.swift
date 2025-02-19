//
//  Date+Extensions.swift
//  PomoTodo
//
//  Created by 심근웅 on 2/18/25.
//

import Foundation

extension Date {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 dd일 (E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
}
