//
//  SegmentedControlView.swift
//  PomoTodo
//
//  Created by 도민준 on 2/20/25.
//

import SwiftUI

struct SegmentedControlView: View {
  @Binding var selectedPeriod: String
  let periods = ["일", "주", "월"]
  var onChange: () -> Void
  
  // 기본 저장 프로퍼티 초기화
  init(selectedPeriod: Binding<String>, onChange: @escaping () -> Void) {
    self._selectedPeriod = selectedPeriod
    self.onChange = onChange
    
    // Segmented Control 색상 설정
    // 선택된 항목 배경색 (선택된 버튼 색)
    UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
    
    // 비활성화된 버튼 배경색 (전체 배경색)
    UISegmentedControl.appearance().backgroundColor = .chartBackground
    
    let attributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: UIColor.black,  // 선택된 텍스트 색상
      .font: UIFont.systemFont(ofSize: 18, weight: .bold) // Bold 처리
    ]
    UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
  }
  
  var body: some View {
    Picker("기간 선택", selection: $selectedPeriod) {
      ForEach(periods, id: \.self) { period in
        Text(period).tag(period)
      }
    }
    .pickerStyle(.segmented)
    .padding(.horizontal, 24)
    .onChange(of: selectedPeriod) {
      onChange()
    }
  }
}
