//
//  RepositoryProvider.swift
//  PomoTodo
//
//  Created by 신승재 on 2/20/25.
//

import Foundation
import SwiftData

final class RepositoryProvider {
  
  private let storage: SwiftDataStorage
  
  init() {
    storage = SwiftDataStorage()
  }
  
  lazy var pomoDayRepository: PomoDayRepository = {
    PomoDayRepositoryImpl(modelContext: storage.modelContext)
  }()
  
  lazy var appConfigRepository: AppConfigRepository = {
    AppConfigRepositoryImpl(modelContext: storage.modelContext)
  }()
}
