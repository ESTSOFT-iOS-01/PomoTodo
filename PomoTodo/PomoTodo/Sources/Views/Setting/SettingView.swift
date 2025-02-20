//
//  SettingView.swift
//  PomoTodo
//
//  Created by 심근웅 on 2/18/25.
//

import SwiftUI

struct SettingView: View {
  @EnvironmentObject var viewModel: SettingViewModel
  @State private var isEditMode: Bool = false
  
  var body: some View {
    NavigationView {
      List {
        // 뽀모도로 타이머 섹션
        Section(header: Text("뽀모도로 설정")) {
          ForEach($viewModel.timers, id: \.index) { pomo in
            NavigationLink(destination: PomoDetailSettingView(pomo: pomo)) {
              PomoSettingRow(timer: pomo)
            }
          }
        }
        // 투두 태그 섹션
        Section(header:TagSettingHeader(isEditMode: $isEditMode)) {
          ForEach($viewModel.options, id: \.id) { tag in
            TagSettingRow(tag: tag, isEditMode: $isEditMode)
          }
        }
      }
      .headerProminence(.increased)
      .navigationTitle("설정")
    }
    .tint(.indigoNormal)
    .environmentObject(viewModel)
  }
}

// 뽀모도로 설정 Row
fileprivate struct PomoSettingRow: View {
  @EnvironmentObject var viewModel: SettingViewModel
  @Binding var timer: PomoTimer // 타이머 설정 정보
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(viewModel.pomoName[timer.index])
        .foregroundStyle(.primary)
      Text("\(Int(timer.focusTimeUnit / 60))분 / \(timer.tomatoPerCycle)개 / \(Int(timer.shortBreakUnit / 60))분 / \(Int(timer.longBreakUnit / 60))분")
        .foregroundStyle(.secondary)
    }
  }
}

// 태그 설정 헤더
fileprivate struct TagSettingHeader: View {
  @EnvironmentObject var viewModel: SettingViewModel
  @Binding var isEditMode: Bool
  
  var body: some View {
    HStack {
      Text("태그 설정")
      Spacer()
      Button {
        isEditMode.toggle()
        if !isEditMode {
          viewModel.send(.tagChanged)
        }
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
  @Binding var tag: Tag
  @Binding var isEditMode: Bool
  
  var body: some View {
    TextField("태그를 입력해주세요", text: $tag.name)
      .disabled(!isEditMode)
  }
}
