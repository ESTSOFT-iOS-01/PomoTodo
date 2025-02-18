//
//  PomoDayRepositoryImpl.swift
//  PomoTodo
//
//  Created by 신승재 on 2/18/25.
//

import Foundation
import SwiftData

final class PomoDayRepositoryImpl {
  private let modelContext: ModelContext
  
  init(modelContext: ModelContext) {
    self.modelContext = modelContext
  }
  
  
  func createPomoDay() {
    print("Impl:", #function)
    
    let today = Date().formattedDate
    
    let result = findPomoDayByDate(today)
    switch result {
    case .success:
      print(SwiftDataError.modelAlreadyExist)
    case .failure(.modelNotFound):
      let model = PomoDayDTO(
        date: today,
        tomatoCnt: 0,
        cycleCnt: 0.0,
        tagTimeRecords: [],
        todos: []
      )
      modelContext.insert(model)
    case .failure(let error):
      print(error)
    }
  }
  
  func getPomoDayByDate(_ date: Date) -> Result<PomoDay, SwiftDataError> {
    print("Impl:", #function)
    
    let result = findPomoDayByDate(date.formattedDate)
    switch result {
    case .success(let model):
      return .success(model.toEntity())
    case .failure(let error):
       return .failure(error)
    }
  }
  
  func addTagTimeRecords(pomoDay: PomoDay, tagTimeRecord: TagTimeRecord) {
    print("Impl:", #function)
    
    let newPomoDay = PomoDay(
      date: pomoDay.date,
      tomatoCnt: pomoDay.tomatoCnt + 1,
      cycleCnt: <#T##Double#>,
      tagTimeRecords: <#T##[TagTimeRecord]#>,
      todos: <#T##[Todo]#>
    )
    
//    let result = findPomoDayByDate(pomoDay.date)
//    switch result {
//      case .success(let model)
//      model.tagTimeRecords.append(tagTimeRecord)
//    case .failure(let error):
//      print(error)):
//    }
  }
}

extension PomoDayRepositoryImpl {
  private func findPomoDayByDate(
    _ date: Date
  ) -> Result<PomoDayDTO, SwiftDataError> {
    print("Impl:", #function)
    
    let targetDate = date
    let predicate = #Predicate<PomoDayDTO> { $0.date == targetDate }
    let descriptor = FetchDescriptor<PomoDayDTO>(predicate: predicate)
    
    do {
      guard let data = try modelContext.fetch(descriptor).first else {
        return .failure(.modelNotFound)
      }
      return .success(data)
    } catch {
      return .failure(.fetchError)
    }
  }
}
