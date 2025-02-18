//
//  SettingView.swift
//  PomoTodo
//
//  Created by 심근웅 on 2/18/25.
//

import SwiftUI

struct SettingView: View {
  @State private var isEditMode: Bool = false // 편집모드
  @State private var pomoTimerArr: [PomoTimer] = [
    PomoTimer(index: 0, focusTimeUnit: 25*60, tomatoPerCycle: 4, shortBreakUnit: 5*60, longBreakUnit: 30*60),
    PomoTimer(index: 1, focusTimeUnit: 25*60, tomatoPerCycle: 4, shortBreakUnit: 5*60, longBreakUnit: 30*60),
    PomoTimer(index: 2, focusTimeUnit: 25*60, tomatoPerCycle: 4, shortBreakUnit: 5*60, longBreakUnit: 30*60)
  ]
  @State private var tags: [Tag] = [
    Tag(index: 0, name: "공부", colorId: 0),
    Tag(index: 1, name: "취미", colorId: 1),
    Tag(index: 2, name: "독서", colorId: 2),
    Tag(index: 3, name: "운동", colorId: 3)
  ]
  private let pomoName: [String] = ["기본 뽀모도로","짧은 뽀모도로","긴 뽀모도로"]
  
  var body: some View {
    NavigationView {
      List {
        Section(header: Text("뽀모도로 설정").modifier(HeaderMdifier(fontsize: 15))) {
          ForEach($pomoTimerArr, id: \.index) { pomoTimer in
            NavigationLink(destination: Text("hello")) {
              PomoSettingRow(pomoTimer: pomoTimer, name: pomoName[pomoTimer.index.wrappedValue])
            }
          }
        }
          
        
        Section(header:TagSettingHeader(isEditMode: $isEditMode, headerText: "태그 설정")) {
          ForEach($tags, id: \.id) { tag in
//            Text(tag.name.wrappedValue)
            TagSettingRow(name: tag.name, isEditMode: $isEditMode)
          }
        }
      }.navigationTitle("설정")
    }
  }
}

// 헤더 공통 속성
fileprivate struct HeaderMdifier: ViewModifier {
  var fontsize: CGFloat
  
  func body(content: Content) -> some View {
    content
    .fontWeight(.semibold)
    .foregroundStyle(.secondary)
    .font(.system(size: fontsize))
  }
}

// 태그 설정 헤더
fileprivate struct TagSettingHeader: View {
  @Binding var isEditMode: Bool
  let headerText: String
  
  var body: some View {
    HStack {
      Text(headerText)
        .modifier(HeaderMdifier(fontsize: 15))
      Spacer()
      Button {
        print("편집 버튼 실행")
        isEditMode.toggle()
        print(isEditMode ? "편집모드" : "편집불가")
      } label: {
        Text(isEditMode ? "완료" : "편집")
      }
    }
  }
}

// 뽀모도로 설정 Row
fileprivate struct PomoSettingRow: View {
  @Binding var pomoTimer: PomoTimer // 타이머 설정 정보
  var name: String // 타이머 이름
  var body: some View {
    VStack(alignment: .leading) {
      Text(name)
        .foregroundStyle(.primary)
      Text("\(Int(pomoTimer.focusTimeUnit/60))분/\(Int(pomoTimer.tomatoPerCycle))개/\(Int(pomoTimer.shortBreakUnit/60))분/\(Int(pomoTimer.longBreakUnit/60))분")
        .foregroundStyle(.secondary)
    }
  }
}

// 태그 설정 Row
fileprivate struct TagSettingRow: View {
  @Binding var name: String // 태그 이름
  @Binding var isEditMode: Bool
  var body: some View {
    TextField("태그를 입력해주세요", text: $name)
      .disabled(!isEditMode)
  }
}
