//
//  PomoBottomView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

struct PomoBottomView: View {
    @EnvironmentObject var pomoVM: PomoViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: DynamicPadding.getWidth(32)) {
            Button {
                pomoVM.startTimer()
            } label: {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(pomoVM.selectedColorSet.normalColor)
                        .frame(width: DynamicPadding.getWidth(128), height: DynamicPadding.getHeight(88), alignment: .center)
                    Image(systemName: "play.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(height: DynamicPadding.getHeight(24))
                }
            }
            Button {
                pomoVM.forwardNextTimer()
            } label: {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(pomoVM.selectedColorSet.normalColor)
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

//#Preview {
//    PomoBottomView(backgroundColor: .tealNormal)
//}
