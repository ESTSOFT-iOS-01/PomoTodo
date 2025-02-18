//
//  PomoTopView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

struct PomoTopView: View {
    let options: [String] // 선택 가능한 옵션 리스트
    @Binding var selectionTag: Int // 선택된 옵션 인덱스
    let curTomato: Int
    let totalTomato: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            // 타이머 진행 상태 텍스트
            Text("\(curTomato) / \(totalTomato)")
                .font(.pretendard(.semiBold, size: 18))
            
            // 메뉴 버튼 (드롭다운)
            Menu {
                ForEach(0..<options.count, id: \.self) { index in
                    Button(action: {
                        selectionTag = index
                    }) {
                        Label(options[index], systemImage: selectionTag == index ? "checkmark" : "")
                    }
                }
            } label: {
                Text(options[selectionTag])
                    .font(.pretendard(.bold, size: 18))
                    .padding(.horizontal, 32)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(.indigoNormal)
                    )
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}
