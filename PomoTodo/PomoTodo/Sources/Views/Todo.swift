//
//  Todo.swift
//  PomoTodo
//
//  Created by 심근웅 on 2/18/25.
//

import Foundation

struct Todo: Identifiable {
    var id: String = UUID().uuidString
    var createAt: Date
    var name: String
    var tagID: String
}

struct Tag: Identifiable {
    var id: String = UUID().uuidString
    var idx: Int
    var name: String
    var colorId: Int
}
