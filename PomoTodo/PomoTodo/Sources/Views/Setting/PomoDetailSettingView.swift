//
//  PomoDetailSettingView.swift
//  PomoTodo
//
//  Created by 심근웅 on 2/19/25.
//

import SwiftUI

fileprivate enum elementBtn: Int {
  case focusTimeUnit = 0
  case tomatoPerCycle
  case shortBreakUnit
  case longBreakUnit
}

struct PomoDetailSettingView: View {
  let viewModel: SettingViewModel
  let pomo: PomoTimer
  let name: String
  @State private var showModal: Bool = false
  @State private var selected: elementBtn = .focusTimeUnit
  
  var body: some View {
    NavigationView {
      List{
        Button {
          showModal = true
          selected = .focusTimeUnit
        } label: {
          DetailRow(name: "집중 시간", value: "\(pomo.focusTimeUnit.intMin)분")
        }.foregroundStyle(.primary)
        
        Button {
          showModal = true
          selected = .tomatoPerCycle
        } label: {
          DetailRow(name: "한 사이클의 토마토 개수", value: "\(pomo.tomatoPerCycle)개")
        }.foregroundStyle(.primary)
        
        Button {
          showModal = true
          selected = .shortBreakUnit
        } label: {
          DetailRow(name: "짧은 휴식시간", value: "\(pomo.shortBreakUnit.intMin)분")
        }.foregroundStyle(.primary)
        
        Button {
          showModal = true
          selected = .longBreakUnit
        } label: {
          DetailRow(name: "긴 휴식시간", value: "\(pomo.longBreakUnit.intMin)분")
        }.foregroundStyle(.primary)
      }
      .sheet(isPresented: $showModal) {
        modal(viewModel: viewModel, pomo: pomo, selected: selected)
          .presentationDetents([.medium])
          .presentationCornerRadius(48)
      }
    }
    .navigationTitle(name)
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
      Image(systemName: "chevron.right")
        .foregroundStyle(.secondary)
        .font(.caption)
    }
  }
}

// 뽀모도로 내부의 정보 변경하는 모달
fileprivate struct modal: View {
  @Environment(\.dismiss) var dismiss
  let viewModel: SettingViewModel
  let pomo: PomoTimer
  let selected: elementBtn
  @State var info: Int = 0
  
  let ranges: [ClosedRange<Int>] = [1...100, 1...8, 1...30, 1...100]
  let names: [String] = ["집중 시간", "한 사이클의 토마토 개수", "짧은 휴식시간", "긴 휴식시간"]
  
  var body: some View {
    VStack {
      Spacer().frame(height: DynamicPadding.getHeight(24))
      Text(names[selected.rawValue])
        .fontWeight(.semibold)
        .font(.system(size: 18))
      Spacer()
      Picker("", selection: $info) {
        ForEach(ranges[selected.rawValue], id: \.self) {
          Text("\($0)")
        }
      }
      .pickerStyle(.wheel)
      .padding(.horizontal, DynamicPadding.getWidth(16))
      Spacer()
      Button {
        switch selected {
        case .focusTimeUnit:
          viewModel.send(.focusTimeUnitChanged(index: pomo.index, value: info))
        case .tomatoPerCycle:
          viewModel.send(.tomatoPerCycleChanged(index: pomo.index, value: info))
        case .shortBreakUnit:
          viewModel.send(.shortBreakUnitChanged(index: pomo.index, value: info))
        case .longBreakUnit:
          viewModel.send(.longBreakUnitChanged(index: pomo.index, value: info))
        }
        viewModel.send(.onAppear)
        dismiss()
      } label: {
        Text("완료")
          .foregroundStyle(Color.white)
          .font(.pretendard(.semiBold, size: 18))
          .frame(maxWidth: .infinity)
      }
      .frame(width: DynamicPadding.getWidth(200), height: DynamicPadding.getHeight(60))
      .background(Color.indigoDark)
      .cornerRadius(DynamicPadding.getWidth(40))
      Spacer().frame(height: DynamicPadding.getHeight(64))
    }
    .onAppear {
      switch selected {
      case .focusTimeUnit:
        info = pomo.focusTimeUnit.intMin
      case .tomatoPerCycle:
        info = pomo.tomatoPerCycle
      case .shortBreakUnit:
        info = pomo.shortBreakUnit.intMin
      case .longBreakUnit:
        info = pomo.longBreakUnit.intMin
      }
    }
  }
}

