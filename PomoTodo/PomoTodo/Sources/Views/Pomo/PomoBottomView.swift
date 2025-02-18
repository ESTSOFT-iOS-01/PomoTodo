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
    var onStart: () -> Void // 실행 버튼 눌렀을 때 동작
    
    var body: some View {
        HStack(alignment: .center, spacing: DynamicPadding.getWidth(32)) {
            Button {
                onStart() // 실행 버튼 클릭 시 타이머 시작 화면으로 변경
                // 카운트 스타트
            } label: {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(backgroundColor)
                        .frame(width: DynamicPadding.getWidth(128), height: DynamicPadding.getHeight(88), alignment: .center)
                    Image(systemName: "play.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(height: DynamicPadding.getHeight(24))
                }
            }
            Button {
                // 다음 세션으로 넘어가기
            } label: {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(backgroundColor)
                        .frame(width: DynamicPadding.getWidth(128), height: DynamicPadding.getHeight(88), alignment: .center)
                    Image(systemName: "forward.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(height: DynamicPadding.getHeight(24))
                }
            }
        }
    }
}

#Preview {
//    PomoBottomView(backgroundColor: .tealNormal)
}
