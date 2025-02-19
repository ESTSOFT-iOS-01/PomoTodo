//
//  SettingView.swift
//  PomoTodo
//
//  Created by 심근웅 on 2/18/25.
//

import SwiftUI

struct SettingView1: View {
  @State private var viewModel: SettingViewModel_
  @State private var isEditMode: Bool = false // 편집모드
  
  init(viewModel: SettingViewModel_) {
    self.viewModel = viewModel
  }
  
  var body: some View {
//    let config = viewModel.state.config
    
    NavigationView {
      List {
        // 뽀모도로 타이머 섹션
        Section(header: Text("뽀모도로 설정")) {
          ForEach(viewModel.state.config.pomoTimers, id: \.index) { pomo in
            NavigationLink(destination: PomoDetailSettingView1(viewModel: viewModel, pomo: pomo)) {
            PomoSettingRow(pomo: pomo)
            }
          }
        }
        // 투두 태그 섹션
        Section(header:TagSettingHeader(isEditMode: $isEditMode)) {
          ForEach(viewModel.state.config.tags, id: \.id) { tag in
            TagSettingRow(viewModel: viewModel, tagId: tag.id, isEditMode: $isEditMode, name: tag.name)
          }
        }
      }
      .headerProminence(.increased)
      .navigationTitle("설정")
    }.tint(.indigoNormal)
  }
}

// 뽀모도로 설정 Row
fileprivate struct PomoSettingRow: View {
  var pomo: PomoTimer // 타이머 설정 정보
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("\(pomo.index+1)번 프리셋")
        .foregroundStyle(.primary)
      Text("\(Int(pomo.focusTimeUnit / 60))분 / \(pomo.tomatoPerCycle)개 / \(Int(pomo.shortBreakUnit / 60))분 / \(Int(pomo.longBreakUnit / 60))분")
        .foregroundStyle(.secondary)
    }
  }
}

// 태그 설정 헤더
fileprivate struct TagSettingHeader: View {
  @Binding var isEditMode: Bool
  
  var body: some View {
    HStack {
      Text("태그 설정")
      Spacer()
      Button {
        isEditMode.toggle()
      } label: {
        Text(isEditMode ? "완료" : "편집")
          .foregroundStyle(Color.indigoNormal)
          .font(.caption)
      }
    }
  }
}

// 태그 설정 Row
fileprivate struct TagSettingRow: View {
  let viewModel: SettingViewModel_
  let tagId: String
  @Binding var isEditMode: Bool
  @State var name: String = ""
  @FocusState private var isFocused: Bool
  
  var body: some View {
    TextField("태그를 입력해주세요", text: $name)
      .disabled(!isEditMode)
      .focused($isFocused)
      .onChange(of: isFocused) { _, focused in
        if !focused {
          print(name)
          // 투두는 하나씩이어서 이게 맞는거 같은데 태그는 완료 버튼이 있기때문에 버튼 쪽에서 처리하는게 맞는듯
//          viewModel.send(.nameChanged(id: tagId, name: name))
        }
      }
  }
}
