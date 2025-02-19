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
  @State var selectedButton: Int = 0
  @State var info: Int = 0
  var name: String = ""
  
  var body: some View {
    NavigationView {
      List{
        Button {
          showModal = true
          selectedButton = 0
          info = Int(pomo.focusTimeUnit / 60)
        } label: {
          DetailRow(name: "집중 시간", value: "\(Int(pomo.focusTimeUnit / 60))분")
        }.foregroundStyle(.primary)
        
        
        
        
        
      }
    }
  }
}
//    NavigationView {
//      List {
//        Button {
//          showModal = true
//          selectedButton = 0
//          info = Int(pomo.focusTimeUnit / 60)
//        } label: {
//          DetailRow(name: "집중 시간", value: "\(Int(pomo.focusTimeUnit / 60))분")
//        }.foregroundStyle(.primary)
//        
//        Button {
//          showModal = true
//          selectedButton = 1
//          info = pomo.tomatoPerCycle
//        } label: {
//          DetailRow(name: "한 사이클의 토마토 개수", value: "\(pomo.tomatoPerCycle)개")
//        }.foregroundStyle(.primary)
//        
//        Button {
//          showModal = true
//          selectedButton = 2
//          info = Int(pomo.shortBreakUnit / 60)
//        } label: {
//          DetailRow(name: "짧은 휴식시간", value: "\(Int(pomo.shortBreakUnit / 60))분")
//        }.foregroundStyle(.primary)
//          
//        Button {
//          showModal = true
//          selectedButton = 3
//          info = Int(pomo.longBreakUnit / 60)
//        } label: {
//          DetailRow(name: "긴 휴식시간", value: "\(Int(pomo.longBreakUnit / 60))분")
//        }.foregroundStyle(.primary)
//          
//      }
//      .sheet(isPresented: $showModal){
//        SettingModal(pomo: $pomo, selected: $info, selectedButton: selectedButton)
//          .presentationDetents([.medium, .large]) // medium 사이즈의 화면, large 사이즈의 버튼
//          .cornerRadius(32)
//      }
//      
//    }
//    .navigationTitle(name)
//    .navigationBarTitleDisplayMode(.inline)
//    
//  }
//}

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
  @Environment(\.dismiss) var dismiss
  @Binding var pomo: PomoTimer
  @Binding var selected: Int
  var selectedButton: Int
  
  
  let range: [ClosedRange<Int>] = [0...100, 1...8, 1...30, 1...100]
  let names: [String] = ["집중 시간", "한 사이클의 토마토 개수", "짧은 휴식시간", "긴 휴식시간"]
  
  var body: some View {
    VStack {
      Text(names[selectedButton])
        .fontWeight(.semibold)
        .font(.system(size: 18))
      
      Picker("", selection: $selected) {
        ForEach(range[selectedButton], id: \.self) {
          Text("\($0)")
        }
      }
      .pickerStyle(.wheel)
      
      Button{
        // 여기서 뽀모타이머 설정 변경 저장
        print($selected)
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
