//
//  ToDoView.swift
//  PomoTodo
//
//  Created by 심근웅 on 2/18/25.
//

import SwiftUI

struct ToDoView: View {
  
  @ObservedObject private var viewModel: ToDoViewModel
  private let color: [Color] = [Color.indigoNormal, Color.blue, Color.cyan, Color.teal ]
  
  init(viewModel: ToDoViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    
    let tags = viewModel.tags
    let todos = viewModel.todos
    
    NavigationView {
      List {
        ForEach(tags, id: \.id) { tag in
          // 섹션 헤더 설정
          Section(header: HeaderView(
            viewModel: viewModel, headerText: tag.name, tag: tag
          )) {
            // 섹션에 들어가는 리스트 생성
            ForEach(todos, id: \.id) { todo in
              if todo.tagId == tag.id {
                TodoRow(
                  viewModel: viewModel,
                  todoId: todo.id,
                  isCompleted: todo.isCompleted,
                  name: todo.name,
                  color: color[tag.colorId]
                )
                .frame(width: UIScreen.main.bounds.width-48)
              }
            }
          }
        }
      }
      .navigationTitle(Date().formattedDateToString)
      .onAppear(perform: UIApplication.shared.hideKeyboard)
      .onAppear {
        viewModel.send(.onAppear)
      }
    }
  }
}

fileprivate struct HeaderView: View {
  var viewModel: ToDoViewModel
  let headerText: String
  let tag: Tag
  
  var body: some View {
    HStack {
      Text(headerText)
        .foregroundStyle(Color.black)
        .fontWeight(.semibold)
        .font(.system(size: 20))
      
      Spacer()
      
      Button {
        viewModel.send(.addEmptyTodo(tagId: tag.id))
      } label: {
        Label("", systemImage: "plus")
          .foregroundStyle(Color.black)
          .fontWeight(.semibold)
      }
    }.frame(width: UIScreen.main.bounds.width-54)
  }
}

fileprivate struct TodoRow: View {
  let viewModel: ToDoViewModel
  let todoId: String
  @State var isCompleted: Bool = false
  @State var name: String = ""
  @FocusState private var isFocused: Bool
  var color: Color
  
  var body: some View {
    HStack {
      Button {
        isCompleted.toggle()
        viewModel.send(.toggleTodo(id: todoId, status: isCompleted))
      } label: {
        Label("", systemImage: isCompleted ? "checkmark.circle" : "circle")
      }.foregroundStyle(color)
      
      TextField("내용을 입력해주세요", text: $name)
        .font(.system(size: 17))
        .strikethrough(isCompleted ? true : false)
        .disableAutocorrection(true)
        .focused($isFocused)
        .onChange(of: isFocused) { _, focused in
           if !focused {
             viewModel.send(.nameChanged(id: todoId, name: name))
           }
         }
    }
    .swipeActions(content: {
      Button(role: .destructive) {
        viewModel.send(.deleteTodo(id: todoId))
      } label: {
        Label("삭제", systemImage: "trash.fill")
      }
    }).tint(.red)
  }
}

#Preview {
  
  let storage = SwiftDataStorage()
  
  ToDoView(
    viewModel: ToDoViewModel(
      pomoTodoUseCase: PomoTodoUseCaseImpl(
        pomoDayRepository: PomoDayRepositoryImpl(
          modelContext: storage.modelContext
        ),
        appConfigRepository: AppConfigRepositoryImpl(
          modelContext: storage.modelContext
        )
      )
    )
  )
}
