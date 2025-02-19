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
            TomatoCountView()
            TagSelectionMenu()
        }
    }
}

//MARK: - 토마토 개수 표시 라벨 Subview
struct TomatoCountView: View {
    @EnvironmentObject var pomoVM: PomoViewModel
    
    var body: some View {
        Text("\(pomoVM.curTomato) / \(pomoVM.totalTomato)")
            .font(.pretendard(.semiBold, size: 18))
    }
}

//MARK: - 태그 메뉴 버튼 Subview
struct TagSelectionMenu: View {
    @EnvironmentObject var pomoVM: PomoViewModel
    
    var body: some View {
        Menu {
            ForEach(0..<pomoVM.options.count, id: \.self) { index in
                Button(action: {
                    pomoVM.selectionTag = index
                }) {
                    // label
                    menuItem(for: index)
                }
            }
        } label: {
            menuLabel()
        }
    }
    
    //MARK: - UI Settings funcs
    
    @ViewBuilder
    private func menuItem(for index: Int) -> some View {
        HStack {
            Text(pomoVM.options[index].name)
            if pomoVM.selectionTag == index {
                Image(systemName: "checkmark")
            }
        }
    }
    
    @ViewBuilder
    private func menuLabel() -> some View {
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
