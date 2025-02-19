//
//  Date+Extensions.swift
//  PomoTodo
//
//  Created by 신승재 on 2/18/25.
//

import Foundation

extension Date {
  static private let configuredCalendar: Calendar = {
    var calendar = Calendar.current
    calendar.locale = .current
    calendar.timeZone = .current
    return calendar
  }()
  
  /// 년, 월, 일 값만 사용하기 위해 형식화한 Date - [Ex. 2024-10-31 15:00:00 +0000]
  var formattedDate: Date {
    Self.configuredCalendar.startOfDay(for: self)
  }
  
  var formattedDateToString: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "M월 dd일 (E)"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: self)
  }
}
