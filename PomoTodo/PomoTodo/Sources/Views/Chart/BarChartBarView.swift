//
//  BarChartBarView.swift
//  PomoTodo
//
//  Created by 도민준 on 2/19/25.
//

import SwiftUI

// 바 차트 바 (ZStack만 분리)
struct BarChartBarView: View {
    var viewModel: StatisticsViewModel
    var record: TagTimeRecord
    var totalFocusTime: TimeInterval
    
    var body: some View {
        let percentage = record.focusTime / max(totalFocusTime, 1) // 퍼센트 계산
        let barWidth = max(CGFloat(percentage) * 200, 50) // 너비 계산
        
        ZStack(alignment: .leading) {
            // 바 차트 (비율에 따라 너비 조절)
            RoundedRectangle(cornerRadius: 16)
                .fill(viewModel.getTagColor(for: record.tagId))
                .frame(width: barWidth, height: 48)
            
            // 퍼센트 텍스트 (바 안쪽)
            Text("\(Int(percentage * 100))%")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
                .padding(.leading, 12)
        }
    }
}
