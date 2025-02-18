//
//  PomoView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

struct PomoView: View {
    var options = ["취미", "짧은 옵션", "중간 길이의 옵션", "정말 길~~~~~~~~~어 보이는 선택 옵션"]
    @State private var selectionTag = 0
    @State private var curTomato = 1
    @State private var totalTomato = 4
    
    var body: some View {
        VStack(alignment: .center) {
            PomoTopView(
                options: options,
                selectionTag: $selectionTag,
                curTomato: curTomato,
                totalTomato: totalTomato
            )
            
            // 센터 뷰
            // 타이머뷰
            // 페이지 컨트롤
            
            // 버튼 뷰
            PomoBottomView()
        }
        .padding(.horizontal, 12)
        
    }
}

#Preview {
    PomoView()
}
