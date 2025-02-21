//
//  PageControl.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

/// **페이지 컨트롤 뷰**
/// - 현재 선택된 페이지를 나타내는 인디케이터
/// - 선택된 페이지는 검은색, 나머지는 반투명 회색
/// - 탭하면 해당 페이지로 전환
struct PageControl: View {
  @EnvironmentObject var pomoVM: PomoViewModel
  
  var body: some View {
    HStack(spacing: 8) {
      ForEach(0..<pomoVM.timers.count, id: \.self) { pagingIndex in
        
        let isCurrentPage = pomoVM.currentPage == pagingIndex
        let height = 8.0
        let width = isCurrentPage ? height * 2 : height
        
        Capsule()
          .fill(isCurrentPage ? .black : .gray.opacity(0.5))
          .frame(width: width, height: height)
          .onTapGesture {
            withAnimation {
              pomoVM.currentPage = pagingIndex
            }
          }
      }
    } // : hstack
    .animation(.linear, value: pomoVM.currentPage)
  }
}

