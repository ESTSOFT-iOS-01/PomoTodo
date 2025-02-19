//
//  PomoDetailSettingView.swift
//  PomoTodo
//
//  Created by 심근웅 on 2/19/25.
//

import SwiftUI

struct PomoDetailSettingView: View {
  @EnvironmentObject var pomoVM: PomoViewModelSetting
  @Binding var pomo: PomoTimer
  @State private var showModal: Bool = false
  @State private var selectedBnt: Int = 0 // 누른 메뉴 번호
  
  var body: some View {
    
    NavigationView {
      List{
        
        Button {
          showModal = true
          selectedBnt = 0
        } label: {
          DetailRow(name: "집중 시간", value: "\(Int(pomo.focusTimeUnit / 60))분")
        }.foregroundStyle(.primary)
        
        Button {
          showModal = true
          selectedBnt = 1
        } label: {
          DetailRow(name: "한 사이클의 토마토 개수", value: "\(pomo.tomatoPerCycle)개")
        }.foregroundStyle(.primary)
        
        Button {
          showModal = true
          selectedBnt = 2
        } label: {
          DetailRow(name: "짧은 휴식시간", value: "\(Int(pomo.shortBreakUnit / 60))분")
        }.foregroundStyle(.primary)
        
        Button {
          showModal = true
          selectedBnt = 3
        } label: {
          DetailRow(name: "긴 휴식시간", value: "\(Int(pomo.longBreakUnit / 60))분")
        }.foregroundStyle(.primary)
        
      }
      .sheet(isPresented: $showModal){
        SettingModal(pomo: $pomo, selectedBnt: selectedBnt).environmentObject(pomoVM)
          .presentationDetents([.medium])
          .presentationCornerRadius(48)
      }
    }
    .navigationTitle(pomoVM.pomoName[pomo.index])
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

// 뽀모도로 내부의 정보 변경하는 모달
fileprivate struct SettingModal: View {
  @EnvironmentObject var pomoVM: PomoViewModelSetting
  @Environment(\.dismiss) var dismiss
  @Binding var pomo: PomoTimer
  let range: [ClosedRange<Int>] = [0...100, 1...8, 1...30, 1...100]
  let names: [String] = ["집중 시간", "한 사이클의 토마토 개수", "짧은 휴식시간", "긴 휴식시간"]
  var selectedBnt: Int
  @State var info: Int = 0
  
  var body: some View {
    VStack {
      Text(names[selectedBnt])
        .fontWeight(.semibold)
        .font(.system(size: 18))
      
      Picker("", selection: $info) {
        ForEach(range[selectedBnt], id: \.self) {
          Text("\($0)")
        }
      }
      .pickerStyle(.wheel)
      
      Button {
        switch selectedBnt {
        case 0: pomoVM.timers[pomo.index].focusTimeUnit = Double(info * 60)
        case 1: pomoVM.timers[pomo.index].tomatoPerCycle = info
        case 2: pomoVM.timers[pomo.index].shortBreakUnit = Double(info * 60)
        case 3: pomoVM.timers[pomo.index].longBreakUnit = Double(info * 60)
        default: print()
        }
        pomoVM.timerSave()
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
    .onAppear {
      switch selectedBnt {
      case 0: self.info = Int(pomo.focusTimeUnit / 60)
      case 1: self.info = pomo.tomatoPerCycle
      case 2: self.info = Int(pomo.shortBreakUnit / 60)
      case 3: self.info = Int(pomo.longBreakUnit / 60)
      default: print()
      }
    }

  }
}
