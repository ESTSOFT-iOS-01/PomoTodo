//
//  PomoDayRepository.swift
//  PomoTodo
//
//  Created by 신승재 on 2/19/25.
//

import Foundation

protocol PomoDayRepository {
  func createPomoDay(_ pomoDay: PomoDay)
  func fetchPomoDay(date: Date) -> Result<PomoDay?, Error>
  func fetchAllPomoDays() -> Result<[PomoDay], Error>
  func updatePomoDay(_ pomoDay: PomoDay)
  func setTodos(pomoDay: PomoDay, todos: [Todo])
}
