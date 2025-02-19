//
//  PageControl.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

struct PageControl: View {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages, id: \.self) { pagingIndex in
                
                let isCurrentPage = currentPage == pagingIndex
                let height = 8.0
                let width = isCurrentPage ? height * 2 : height
                
                Capsule()
                    .fill(isCurrentPage ? .black : .gray.opacity(0.5))
                    .frame(width: width, height: height)
            }
        }
        .animation(.linear, value: currentPage)
    }
}

#Preview {
    PageControl(numberOfPages: 3, currentPage: .constant(0))
}
