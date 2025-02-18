//
//  ToDoView.swift
//  PomoTodo
//
//  Created by 심근웅 on 2/18/25.
//

import SwiftUI

struct ToDoView: View {
  @State private var todoArr: [Todo]
  
  private let color: [Color] = [Color.indigoNormal, Color.blue, Color.cyan, Color.teal ]
  private var tags: [Tag] = [
    Tag(index: 0, name: "공부", colorId: 0),
    Tag(index: 1, name: "취미", colorId: 1),
    Tag(index: 2, name: "독서", colorId: 2),
    Tag(index: 3, name: "운동", colorId: 3)
  ]
  private var today: String = Date().formattedDate
  
  init() {
    //        // 더미데이터
    //        tags = [
    //            Tag(idx: 0, name: "공부", colorId: 0),
    //            Tag(idx: 1, name: "취미", colorId: 1),
    //            Tag(idx: 2, name: "독서", colorId: 2),
    //            Tag(idx: 3, name: "운동", colorId: 3)
    //        ]
    //        todoArr = [
    //            Todo(createAt: Date(), name: "SwiftUI", tagID: tags[0].id),
    //            Todo(createAt: Date(), name: "RxSwiftUI", tagID: tags[0].id),
    //            Todo(createAt: Date(), name: "UIKit", tagID: tags[0].id),
    //            Todo(createAt: Date(), name: "하이킹", tagID: tags[1].id),
    //            Todo(createAt: Date(), name: "스키", tagID: tags[1].id),
    //            Todo(createAt: Date(), name: "수영", tagID: tags[1].id),
    //            Todo(createAt: Date(), name: "삼국지", tagID: tags[2].id),
    //            Todo(createAt: Date(), name: "헬스", tagID: tags[3].id),
    //            Todo(createAt: Date(), name: "필라테스", tagID: tags[3].id)
    //        ]
    // 더미데이터
    todoArr = [
      Todo(tagId: tags[0].id, name: "SwiftUI", isCompleted: true),
      Todo(tagId: tags[0].id, name: "RxSwiftUI"),
      Todo(tagId: tags[0].id, name: "UIKit"),
      Todo(tagId: tags[1].id, name: "하이킹"),
      Todo(tagId: tags[1].id, name: "스키"),
      Todo(tagId: tags[1].id, name: "수영"),
      Todo(tagId: tags[2].id, name: "삼국지"),
      Todo(tagId: tags[3].id, name: "헬스"),
      Todo(tagId: tags[3].id, name: "필라테스")
    ]
  }
  
  var body: some View {
    NavigationView {
      List {
        ForEach(tags, id: \.id) { tag in
          // 섹션 헤더 설정
          Section(header: HeaderView(todoArr: $todoArr, headerText: tag.name, tag: tag)) {
            // 섹션에 들어가는 리스트 생성
            ForEach(todoArr, id: \.id) { todo in
              if todo.tagId == tag.id {
                TodoRow(isCompleted: todo.isCompleted, name: todo.name, color: color[tag.colorId])
                  .frame(width: UIScreen.main.bounds.width-48)
                  .swipeActions(content: {
                    Button(role: .destructive) {
                      let idx = todoArr.firstIndex(where: { todo.id == $0.id })!
                      todoArr.remove(at: idx)
                    } label: {
                      Label("삭제", systemImage: "trash.fill")
                    }
                  })
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
  @Binding var todoArr: [Todo]
  let headerText: String
  let tag: Tag
  
  var body: some View {
    HStack{
      Text(headerText)
        .foregroundStyle(Color.black)
        .fontWeight(.semibold)
        .font(.system(size: 20))
      Spacer()
      
      Button {
        todoArr.append(Todo(tagId: tag.id, name: ""))
      } label: {
        Label("", systemImage: "plus")
          .foregroundStyle(Color.black)
          .fontWeight(.semibold)
      }
    }.frame(width: UIScreen.main.bounds.width-54)
  }
}

fileprivate struct TodoRow: View {
  @State var isCompleted: Bool = false
  @State var name: String = "확인용 테스트 문자열입니다"
  var color: Color
  
  var body: some View {
    HStack {
      Button {
        isCompleted.toggle()
      } label: {
        Label("", systemImage: isCompleted ? "checkmark.circle" : "circle")
      }.foregroundStyle(color)
      
      TextField("내용을 입력해주세요", text: $name)
        .font(.system(size: 17))
        .strikethrough(isCompleted ? true : false)
        .disableAutocorrection(true)
    }
  }
}

#Preview {
  ToDoView()
}

