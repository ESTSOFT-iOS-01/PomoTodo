//
//  PomoTopView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

struct PomoTopView: View {
    @EnvironmentObject var pomoVM: PomoViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: DynamicPadding.getHeight(16)) {
            // 타이머 진행 상태 텍스트
            Text("\(pomoVM.curTomato) / \(pomoVM.totalTomato)")
                .font(.pretendard(.semiBold, size: 18))
            
            // 메뉴 버튼 (드롭다운)
            Menu {
                ForEach(0..<pomoVM.options.count, id: \.self) { index in
                    Button(action: {
                        pomoVM.selectionTag = index
                    }) {
                        Label(pomoVM.options[index].name, systemImage: pomoVM.selectionTag == index ? "checkmark" : "")
                    }
                }
            } label: {
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
    }
}
