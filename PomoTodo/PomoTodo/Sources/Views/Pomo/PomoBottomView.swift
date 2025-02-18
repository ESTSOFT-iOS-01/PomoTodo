//
//  PomoBottomView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

struct PomoBottomView: View {
    var backgroundColor: Color = .indigoNormal
    // 여기에 뷰모델 선언
    
    var body: some View {
        HStack(alignment: .center, spacing: 32) {
            Button {
                // UI 변경
                // 카운트 스타트
            } label: {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(backgroundColor)
                        .frame(width: 128, height: 88, alignment: .center)
                    Image(systemName: "play.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(height: 24)
                }
            }
            Button {
                // 다음 세션으로 넘어가기
            } label: {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(backgroundColor)
                        .frame(width: 128, height: 88, alignment: .center)
                    Image(systemName: "forward.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(height: 24)
                }
            }
        }
    }
}

#Preview {
    PomoBottomView(backgroundColor: .tealNormal)
}
