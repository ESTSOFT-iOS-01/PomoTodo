//
//  PageControl.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

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
        }
        .animation(.linear, value: pomoVM.currentPage)
    }
}

//#Preview {
//    PageControl(numberOfPages: 3, currentPage: .constant(0))
//}
