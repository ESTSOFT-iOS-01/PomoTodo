//
//  SectionView.swift
//  PomoTodo
//
//  Created by 도민준 on 2/18/25.
//

import SwiftUI

// MARK: - 섹션 Background 뷰
struct SectionView<Content: View>: View {
  let content: Content
  
  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
  
  var body: some View {
    content
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 12)
          .fill(.chartBackground)
      )
      .padding(.horizontal, 24)
  }
}


//#Preview {
//    SectionView
//}
