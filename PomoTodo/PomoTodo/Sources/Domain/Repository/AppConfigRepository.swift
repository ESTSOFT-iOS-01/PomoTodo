//
//  AppConfigRepository.swift
//  PomoTodo
//
//  Created by 신승재 on 2/18/25.
//

import Foundation

protocol AppConfigRepository {
  func createAppConfig(_ appConfig: AppConfig)
  func fetchAppConfig() -> Result<AppConfig?, Error>
  func updateAppConfig(_ appConfig: AppConfig)
  func fetchPomoTimer(index: Int) -> Result<PomoTimer, Error>
  //func updatePomoTimer(_ pomoTimer: PomoTimer)
  //func updateTags(_ tags: [Tag])
}
