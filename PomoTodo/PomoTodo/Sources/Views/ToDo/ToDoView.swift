//
//  ToDoView.swift
//  PomoTodo
//
//  Created by 심근웅 on 2/18/25.
//

import SwiftUI

struct ToDoView: View {
  
  @State private var viewModel: ToDoViewModel
  
  private let color: [Color] = [Color.indigoNormal, Color.blue, Color.cyan, Color.teal ]
  private var today: String = Date().formattedDateToString
  
  init(viewModel: ToDoViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    let tags = viewModel.state.tags
    let todos = viewModel.state.todos
    
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
              }
            }
          }
        }
      }
      .navigationTitle(today)
      .onAppear(perform: UIApplication.shared.hideKeyboard)
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
    }
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
        Label("", systemImage: isCompleted ? "checkmark.circle.fill" : "circle")
          .labelStyle(.iconOnly)
      }
      .foregroundStyle(color)
      .padding(.horizontal, DynamicPadding.getWidth(8))
      
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
    .swipeActions(allowsFullSwipe: false) {
      Button(role: .destructive) {
        viewModel.send(.deleteTodo(id: todoId))
      } label: {
        Label("삭제", systemImage: "trash.fill")
      }
    }.tint(.red)
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
