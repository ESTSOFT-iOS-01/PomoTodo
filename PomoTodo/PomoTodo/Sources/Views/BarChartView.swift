//
//  BarChartView.swift
//  PomoTodo
//
//  Created by 도민준 on 2/18/25.
//

import SwiftUI
import Charts

struct BarChartView: View {
  struct ChartData: Identifiable {
    let id = UUID()
    let tagName: String
    let focusTime: TimeInterval  // 초 단위
    let percentage: Double
    let color: Color
  }
  
  let data: [ChartData] = [
    ChartData(tagName: "취미", focusTime: 4 * 3600 + 12 * 60, percentage: 50, color: .indigoNormal),
    ChartData(tagName: "공부", focusTime: 2 * 3600 + 59 * 60, percentage: 30, color: .blueNormal),
    ChartData(tagName: "독서", focusTime: 1 * 3600 + 24 * 60, percentage: 20, color: .cyanNormal),
    ChartData(tagName: "운동", focusTime: 49 * 60, percentage: 10, color: .tealNormal)
  ]
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      ForEach(data) { item in
        HStack(spacing: 12) {
          ZStack(alignment: .leading) {
            // 바 차트 (비율에 따라 너비 조절)
            RoundedRectangle(cornerRadius: 16)
              .fill(item.color)
              .frame(width: max(CGFloat(item.percentage) * 2.5, 50), height: 48) // ‼️ 최소 너비 임시로 50 설정
            
            // 퍼센트 텍스트 (바 안쪽)
            Text("\(Int(item.percentage))%")
              .font(.system(size: 14, weight: .bold))
              .foregroundColor(.white)
              .padding(.top, 15)
              .padding(.leading, 12)
              .padding(.bottom, 15)
          }
          
          // 태그명 & 시간
          VStack(alignment: .leading) {
            Text(item.tagName)
              .font(.system(size: 16, weight: .bold))
            Text(formatTime(item.focusTime))
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
  
  // 초 -> "xh ym" 포맷 변환 함수
  func formatTime(_ seconds: TimeInterval) -> String {
    let hours = Int(seconds) / 3600
    let minutes = (Int(seconds) % 3600) / 60
    return "\(hours)h \(minutes)m"
  }
}

#Preview {
  BarChartView()
}
