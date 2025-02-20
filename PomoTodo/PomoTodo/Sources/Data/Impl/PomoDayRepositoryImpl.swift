//
//  PomoDayRepositoryImpl.swift
//  PomoTodo
//
//  Created by 신승재 on 2/18/25.
//

import Foundation
import SwiftData

final class PomoDayRepositoryImpl: PomoDayRepository {
  
  private let modelContext: ModelContext
  
  init(modelContext: ModelContext) {
    self.modelContext = modelContext
  }
  
  func createPomoDay(_ pomoDay: PomoDay) {
    print("Impl:", #function)
    
    let result = findPomoDayByDate(pomoDay.date)
    switch result {
    case .success:
      print(SwiftDataError.modelAlreadyExist)
    case .failure(.modelNotFound):
      let model = PomoDayDTO(pomoDay)
      modelContext.insert(model)
    case .failure(let error):
      print(error)
    }
  }
  
  func fetchPomoDay(date: Date) -> Result<PomoDay?, any Error> {
    print("Impl:", #function)
    
    let targetDate = date
    let predicate = #Predicate<PomoDayDTO> { $0.date == targetDate }
    let descriptor = FetchDescriptor<PomoDayDTO>(predicate: predicate)
    
    do {
      guard let data = try modelContext.fetch(descriptor).first else {
        print(SwiftDataError.modelNotFound)
        return .success(nil)
      }
      return .success(data.toEntity())
    } catch {
      return .failure(SwiftDataError.fetchError)
    }
  }
  
  func fetchAllPomoDays() -> Result<[PomoDay], any Error> {
    print("Impl:", #function)
    
    let now = Date().formattedDate
    let predicate = #Predicate<PomoDayDTO> { $0.date <= now }
    let sort = SortDescriptor(\PomoDayDTO.date, order: .forward)
    let descriptor = FetchDescriptor(predicate: predicate, sortBy: [sort])
    
    do {
      let datas = try modelContext.fetch(descriptor)
      return .success(datas.map { $0.toEntity() })
    } catch {
      return .failure(SwiftDataError.fetchError)
    }
  }
  
  //  func updatePomoDay(_ pomoDay: PomoDay) {
  //    print("Impl:", #function)
  //
  //    let result = findPomoDayByDate(pomoDay.date)
  //    switch result {
  //    case .success(let model):
  //      modelContext.delete(model)
  //      modelContext.insert(model)
  //    case .failure(let error):
  //      print(error)
  //    }
  //  }
  
  func updatePomoDay(_ pomoDay: PomoDay) {
    print("Impl:", #function)
    
    let result = findPomoDayByDate(pomoDay.date)
    switch result {
    case .success(let model):
      model.cycleCnt = pomoDay.cycleCnt
      model.tomatoCnt = pomoDay.tomatoCnt
      model.tagTimeRecords.forEach { modelContext.delete($0) }
      model.todos.forEach { modelContext.delete($0) }
      model.tagTimeRecords = pomoDay.tagTimeRecords.map { TagTimeRecordDTO($0) }
      model.todos = pomoDay.todos.map { TodoDTO($0) }
    case .failure(let error):
      print(error)
    }
  }
  
  func setTodos(pomoDay: PomoDay, todos: [Todo]) {
    print("Impl:", #function)
    
    let result = findPomoDayByDate(pomoDay.date)
    switch result {
    case .success(let model):
      model.todos.forEach { modelContext.delete($0) }
      model.todos = todos.map { TodoDTO($0) }
    case .failure(let error):
      print(error)
    }
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
