//
//  PomoTopView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

/// 타이머 상단 정보 뷰
/// - **토마토 진행 상태** 및 **태그 선택 메뉴** 표시
struct PomoTopView: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    VStack(alignment: .center, spacing: DynamicPadding.getHeight(16)) {
      TomatoCountView()
      TagSelectionMenu()
    }
  }
}

/// 현재 진행 중인 토마토 개수 및 총 토마토 개수 표시
struct TomatoCountView: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    HStack(alignment: .bottom, spacing: 12) {
      Image(systemName: pomoVM.currentPhase == .focus ? Constants.Timer.Symbol.running : Constants.Timer.Symbol.stretching)
        .resizable()
        .scaledToFit()
        .frame(height: 24, alignment: .center)
      
      Text("\(pomoVM.curTomato) / \(pomoVM.totalTomato)")
        .font(.pretendard(.semiBold, size: 18))
    }
  }
}

/// 현재 선택된 태그(카테고리)를 표시하고 변경할 수 있는 메뉴
struct TagSelectionMenu: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    Menu {
      ForEach(0..<pomoVM.options.count, id: \.self) { index in
        Button(action: {
          pomoVM.selectionTag = index
        }) {
          /// 선택 가능한 태그 리스트 표시
          menuItem(for: index)
        }
      }
    } label: {
      /// 현재 선택된 태그를 보여주는 버튼/
      menuLabel()
    }
  }
  
  // MARK: - UI Helper Methods
  /// 태그 리스트 내 개별 항목 (선택 가능)
  @ViewBuilder
  private func menuItem(for index: Int) -> some View {
    HStack {
      Text(pomoVM.options[index].name)
      if pomoVM.selectionTag == index {
        Image(systemName: Constants.Timer.Symbol.checkmark)
      }
    }
  }
  
  /// 현재 선택된 태그를 표시하는 버튼
  @ViewBuilder
  private func menuLabel() -> some View {
    Text(pomoVM.options[pomoVM.selectionTag].name)
      .font(.pretendard(.bold, size: 18))
      .padding(.horizontal, 32)
      .padding(.vertical, 10)
      .background(
        RoundedRectangle(cornerRadius: 24)
          .fill(pomoVM.selectedColorSet.normalColor)
      )
      .foregroundColor(.white)
      .frame(maxWidth: DynamicPadding.getWidth(354))
  }
}
