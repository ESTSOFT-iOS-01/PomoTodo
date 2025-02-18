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

struct BarChartView: View {
  
  let pomoDay: PomoDay
  var chartData: [ChartData] { convertToChartData(from: pomoDay) }
  
//  let data: [ChartData] = [
//    ChartData(tagName: "취미", focusTime: 4 * 3600 + 12 * 60, percentage: 50, color: .indigoNormal),
//    ChartData(tagName: "공부", focusTime: 2 * 3600 + 59 * 60, percentage: 30, color: .blueNormal),
//    ChartData(tagName: "독서", focusTime: 1 * 3600 + 24 * 60, percentage: 20, color: .cyanNormal),
//    ChartData(tagName: "운동", focusTime: 49 * 60, percentage: 10, color: .tealNormal)
//  ]
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      ForEach(chartData) { item in
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
  
  
}

extension BarChartView {
  // 초 -> "xh ym" 포맷 변환 함수
  func formatTime(_ seconds: TimeInterval) -> String {
    let hours = Int(seconds) / 3600
    let minutes = (Int(seconds) % 3600) / 60
    return hours > 0 ? "\(hours)h \(minutes)m" : "\(minutes)m"
  }
  
  func convertToChartData(from pomoDay: PomoDay) -> [ChartData] {
      let totalFocusTime = pomoDay.totalTime // 전체 집중 시간

      return pomoDay.tagTimeRecords.map { record in
          let tagName = pomoDay.todos.first(where: { $0.tagId == record.tagId })?.name ?? "Unknown" // 태그 이름 찾기
          let percentage = totalFocusTime > 0 ? (record.focusTime / totalFocusTime) * 100 : 0

          return ChartData(
              tagName: tagName,
              focusTime: record.focusTime,
              percentage: percentage,
              color: getColor(for: record.tagId)
          )
      }
  }

  // 태그별 고유한 색상 지정 (랜덤 가능)
  func getColor(for tagId: String) -> Color {
      let colorMapping: [String: Color] = [
          "1": .indigoNormal,    // 공부
          "2": .blueNormal,    // 운동
          "3": .cyanNormal,    // 독서
          "4": .tealNormal   // 취미
      ]
      
      return colorMapping[tagId] ?? .gray // ✅ 등록되지 않은 태그 ID는 기본 회색
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
  BarChartView(pomoDay: samplePomoDay)
}
