//
//  TodoRow.swift
//  PomoTodo
//
//  Created by 심근웅 on 2/18/25.
//

import SwiftUI

struct TodoRow: View {
  
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
  TodoRow(color: Color.indigo)
}

