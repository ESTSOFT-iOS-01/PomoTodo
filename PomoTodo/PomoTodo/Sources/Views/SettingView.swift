//
//  SettingView.swift
//  PomoTodo
//
//  Created by 심근웅 on 2/18/25.
//

import SwiftUI

struct SettingView: View {
  @StateObject var pomoVM: PomoViewModelSetting = PomoViewModelSetting()
  @State private var isEditMode: Bool = false // 편집모드
  
  var body: some View {
    NavigationView {
      List {
        // 뽀모도로 타이머 섹션
        Section(header: Text("뽀모도로 설정").modifier(HeaderMdifier(fontsize: 15))) {
          ForEach($pomoVM.timers, id: \.index) { pomo in
            NavigationLink(destination: PomoDetailSettingView(pomo: pomo).environmentObject(pomoVM)) {
              PomoSettingRow(pomo: pomo).environmentObject(pomoVM)
            }
          }
        }
        
        // 투두 태그 섹션
        Section(header:TagSettingHeader(isEditMode: $isEditMode).environmentObject(pomoVM)) {
          ForEach($pomoVM.options, id: \.id) { tag in
            TagSettingRow(option: tag, isEditMode: $isEditMode)
          }
        }
      }
      .navigationTitle("설정")
    }
  }
}

// 헤더 공통 속성

fileprivate struct HeaderMdifier: ViewModifier {
  var fontsize: CGFloat
  
  func body(content: Content) -> some View {
    content
      .foregroundStyle(.secondary)
      .fontWeight(.semibold)
      .font(.system(size: fontsize))
  }
}

// 뽀모도로 설정 Row
fileprivate struct PomoSettingRow: View {
  @EnvironmentObject var pomoVM: PomoViewModelSetting
  @Binding var pomo: PomoTimer // 타이머 설정 정보
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(pomoVM.pomoName[pomo.index])
        .foregroundStyle(.primary)
      Text("\(Int(pomo.focusTimeUnit / 60))분 / \(pomo.tomatoPerCycle)개 / \(Int(pomo.shortBreakUnit / 60))분 / \(Int(pomo.longBreakUnit / 60))분")
        .foregroundStyle(.secondary)
    }
  }
}

fileprivate struct TagSettingHeader: View {
  @EnvironmentObject var pomoVM: PomoViewModelSetting
  @Binding var isEditMode: Bool
  var body: some View {
    HStack {
      Text("태그 설정")
        .modifier(HeaderMdifier(fontsize: 15))
      Spacer()
      Button {
        editBntTouch()
      } label: {
        Text(isEditMode ? "완료" : "편집")
          .foregroundStyle(Color.indigoNormal)
      }
    }
  }
  func editBntTouch() {
    isEditMode.toggle()
    print(isEditMode ? "편집모드" : "편집불가")
    if !isEditMode {
      pomoVM.optionsSave()
    }
  }
}
// 태그 설정 Row
fileprivate struct TagSettingRow: View {
  @Binding var option: Tag
  @Binding var isEditMode: Bool
  
  var body: some View {
    TextField("태그를 입력해주세요", text: $option.name)
      .disabled(!isEditMode)
  }
}
