//
//  BarChartView.swift
//  PomoTodo
//
//  Created by 도민준 on 2/18/25.
//

import SwiftUI
import Charts

// MARK: - 바 차트 뷰
struct BarChartView: View {
  @ObservedObject var viewModel: StatisticsViewModel
  
  private var totalFocusTime: TimeInterval {
    viewModel.totalFocusTime
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      ForEach(viewModel.tagFocusData, id: \.tagId) { record in
        HStack(spacing: 12) {
          // 바 차트 바 (ZStack만 분리)
          BarChartBarView(viewModel: viewModel, record: record, totalFocusTime: totalFocusTime)
          
          // 태그명 & 시간
          VStack(alignment: .leading) {
            let tagName = viewModel.getTagName(for: record.tagId)
            let formattedTime = record.focusTime.formattedTime()
            
            Text(tagName)
              .font(.system(size: 16, weight: .bold))
            Text(formattedTime)
              .font(.system(size: 14, weight: .semibold))
          }
        }
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 12)
        .fill(Color.clear)
    )
  }
}

#Preview {
  BarChartView(viewModel: StatisticsViewModel())
}
