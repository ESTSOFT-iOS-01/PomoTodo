//
//  Font+Extensions.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

/// Pretendard 폰트 가중치 Enum
enum PretendardWeight: String {
    case thin = "Pretendard-Thin"
    case regular = "Pretendard-Regular"
    case medium = "Pretendard-Medium"
    case light = "Pretendard-Light"
    case extraLight = "Pretendard-ExtraLight"
    case extraBold = "Pretendard-ExtraBold"
    case bold = "Pretendard-Bold"
    case semiBold = "Pretendard-SemiBold"
    case black = "Pretendard-Black"
}

extension Font {
    static func pretendard(_ weight: PretendardWeight, size: CGFloat) -> Font {
        Font.custom(weight.rawValue, size: size)
    }
}
