//
//  PomoDetailSettingView.swift
//  PomoTodo
//
//  Created by 심근웅 on 2/19/25.
//

import SwiftUI

struct PomoDetailSettingView1: View {
  let viewModel: SettingViewModel_
  @State private var showModal: Bool = false // 모달이 올라오는게 만듬
  var pomo: PomoTimer
  
//  let range: [ClosedRange<Int>] = [0...100, 1...8, 1...30, 1...100] // 각 요소별 피커 값의 범위
  let names: [String] = ["집중 시간", "한 사이클의 토마토 개수", "짧은 휴식시간", "긴 휴식시간"] // 각 요소의 이름
  
  @State var value: Int = 0
  @State var range: ClosedRange<Int> = 1...8
  
  var body: some View {
    NavigationView {
      List{

        Button {
          value = Int(pomo.focusTimeUnit / 60)
          range = 1...100
          showModal = true
        } label: {
          DetailRow(name: "집중 시간", value: "\(Int(pomo.focusTimeUnit / 60))분")
        }.foregroundStyle(.primary)
        
        Button {
          value = pomo.tomatoPerCycle
          range = 1...8
          showModal = true
        } label: {
          DetailRow(name: "한 사이클의 토마토 개수", value: "\(pomo.tomatoPerCycle)개")
        }.foregroundStyle(.primary)
        
        Button {
          value = Int(pomo.shortBreakUnit / 60)
          range = 1...30
          showModal = true
        } label: {
          DetailRow(name: "짧은 휴식시간", value: "\(Int(pomo.shortBreakUnit / 60))분")
        }.foregroundStyle(.primary)
        
        Button {
          value = Int(pomo.longBreakUnit / 60)
          range = 1...100
          showModal = true
        } label: {
          DetailRow(name: "긴 휴식시간", value: "\(Int(pomo.longBreakUnit / 60))분")
        }.foregroundStyle(.primary)
        
      }
      .sheet(isPresented: $showModal) {
        // 모달 뷰
        modal(viewModal: viewModel, value: value, range: range, pomo: pomo)
          .presentationDetents([.medium])
          .presentationCornerRadius(48)
      }
    }
    .navigationTitle("\(pomo.index+1)번 프리셋")
    .navigationBarTitleDisplayMode(.inline)
  }
}

fileprivate struct DetailRow: View {
  var name: String
  var value: String
  var body: some View {
    HStack {
      Text(name)
      Spacer()
      Text(value)
        .foregroundStyle(.secondary)
      Label("", systemImage: "chevron.right")
        .labelStyle(.iconOnly)
        .foregroundStyle(.secondary)
    }
  }
}

fileprivate struct modal: View {
  let viewModal: SettingViewModel_
  @Environment(\.dismiss) var dismiss
  @State var value: Int = 0 // 피커가 선택한 값
  let range: ClosedRange<Int>
  let pomo: PomoTimer
  
  
  var body: some View {
    VStack {
      Text("타이틀")
        .fontWeight(.semibold)
        .font(.system(size: 18))

      Picker("", selection: $value) {
        ForEach(range, id: \.self) {
          Text("\($0)")
        }
      }
      .pickerStyle(.wheel)
      
      Button {
        dismiss()
      } label: {
        Text("완료")
          .foregroundStyle(Color.white)
          .font(.pretendard(.semiBold, size: 18))
          .frame(maxWidth: .infinity)
      }
      .frame(height: 60)
      .background(Color.indigoDark)
      .cornerRadius(40)
      
    }
    .frame(width: 200)
  }
}
