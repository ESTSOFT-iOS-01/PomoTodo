//
//  BarChartView.swift
//  PomoTodo
//
//  Created by 도민준 on 2/18/25.
//

import SwiftUI
import Charts

// 차트 데이터 모델
struct ChartData: Identifiable {
  let id = UUID()
  let tagName: String  // 태그 이름
  let focusTime: TimeInterval  // 초 단위 집중 시간
  let percentage: Double  // 전체 대비 비율
  let color: Color  // 차트 색상
}

// MARK: - 바 차트 뷰
struct BarChartView: View {
  @ObservedObject var viewModel: StatisticsViewModel
  
  private var totalFocusTime: TimeInterval {
    viewModel.totalFocusTime
  }
  
  //  let data: [ChartData] = [
  //    ChartData(tagName: "취미", focusTime: 4 * 3600 + 12 * 60, percentage: 50, color: .indigoNormal),
  //    ChartData(tagName: "공부", focusTime: 2 * 3600 + 59 * 60, percentage: 30, color: .blueNormal),
  //    ChartData(tagName: "독서", focusTime: 1 * 3600 + 24 * 60, percentage: 20, color: .cyanNormal),
  //    ChartData(tagName: "운동", focusTime: 49 * 60, percentage: 10, color: .tealNormal)
  //  ]
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      ForEach(viewModel.tagFocusData, id: \.tagId) { record in
        HStack(spacing: 12) {
          ZStack(alignment: .leading) {
            let percentage = record.focusTime / max(totalFocusTime, 1) // 퍼센트 계산 분리
            let barWidth = max(CGFloat(percentage) * 200, 50) // 너비 계산 분리
            
            // 바 차트 (비율에 따라 너비 조절)
            RoundedRectangle(cornerRadius: 16)
              .fill(viewModel.getTagColor(for: record.tagId))
              .frame(width: barWidth, height: 48)
            
            // 퍼센트 텍스트 (바 안쪽)
            Text("\(Int(percentage * 100))%")
              .font(.system(size: 14, weight: .bold))
              .foregroundColor(.white)
              .padding(.top, 15)
              .padding(.leading, 12)
              .padding(.bottom, 15)
          }
          
          // 태그명 & 시간
          VStack(alignment: .leading) {
            Text(viewModel.getTagName(for: record.tagId))
              .font(.system(size: 16, weight: .bold))
            Text(viewModel.formatTime(record.focusTime))
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


let samplePomoDay = PomoDay(
  date: Date(),
  tomatoCnt: 5,
  cycleCnt: 2.5,
  tagTimeRecords: [
    TagTimeRecord(tagId: "1", focusTime: 7200), // 2시간
    TagTimeRecord(tagId: "2", focusTime: 3600), // 1시간
    TagTimeRecord(tagId: "3", focusTime: 1800),  // 30분
    TagTimeRecord(tagId: "4", focusTime: 600),  // 10분
  ],
  todos: [
    Todo(tagId: "1", name: "공부"),
    Todo(tagId: "2", name: "운동"),
    Todo(tagId: "3", name: "독서"),
    Todo(tagId: "4", name: "취미")
  ]
)

#Preview {
  BarChartView(viewModel: StatisticsViewModel())
}
