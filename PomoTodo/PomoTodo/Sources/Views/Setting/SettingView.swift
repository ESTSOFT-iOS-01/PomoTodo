//
//  SettingView.swift
//  PomoTodo
//
//  Created by 심근웅 on 2/18/25.
//

import SwiftUI

struct SettingView: View {
  @ObservedObject private var viewModel: SettingViewModel
  let pomoName: [String] = ["1번 프리셋","2번 프리셋","3번 프리셋"]
  @State private var isEditMode: Bool = false
  
  init(viewModel: SettingViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    let tags = viewModel.config.tags
    let pomoTimers = viewModel.config.pomoTimers
  
    NavigationView {
      List {
        // 뽀모도로 타이머 섹션
        Section(header: Text("뽀모도로 설정")) {
          ForEach(pomoTimers, id: \.index) { timer in
            NavigationLink(destination: PomoDetailSettingView(viewModel: viewModel, pomo: timer, name: pomoName[timer.index])) {
              PomoSettingRow(timer: timer, name: pomoName[timer.index])
            }
          }
        }
        
        

//            NavigationLink(destination: PomoDetailSettingView(pomo: pomo, name: pomoName[pomo.index])) {

        // 투두 태그 섹션
        Section(header: TagSettingHeader(isEditMode: $isEditMode)) {
          ForEach(tags, id: \.id) { tag in
            TagSettingRow(viewModel: viewModel, tagIndex: tag.index, name: tag.name, isEditMode: $isEditMode)
          }
        }
      }
      .headerProminence(.increased)
      .navigationTitle("설정")
    }
    .tint(.indigoNormal)
  }
}

// 뽀모도로 설정 Row
fileprivate struct PomoSettingRow: View {
  let timer: PomoTimer
  let name: String
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(name)
        .foregroundStyle(.primary)
      Text("\(timer.focusTimeUnit.intMin)분 / \(timer.tomatoPerCycle)개 / \(timer.shortBreakUnit.intMin)분 / \(timer.longBreakUnit.intMin)분")
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
  let viewModel: SettingViewModel
  let tagIndex: Int
  @State var name: String = ""
  @Binding var isEditMode: Bool
  @FocusState private var isFocused: Bool
  
  var body: some View {
    TextField("태그를 입력해주세요", text: $name)
      .disabled(!isEditMode)
      .tint(.blue)
      .focused($isFocused)
      .onChange(of: isFocused) { _, focused in
        if !focused {
          viewModel.send(.tagNameChanged(index: tagIndex, name: name))
        }
      }
  }
}
