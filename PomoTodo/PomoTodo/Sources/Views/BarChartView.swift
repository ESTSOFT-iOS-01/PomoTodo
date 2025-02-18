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
        let category: String
        let percentage: Double
        let time: String
    }

    // 샘플 데이터
    let data: [ChartData] = [
        ChartData(category: "취미", percentage: 50, time: "4h 12m"),
        ChartData(category: "공부", percentage: 30, time: "2h 59m"),
        ChartData(category: "독서", percentage: 20, time: "1h 24m"),
        ChartData(category: "운동", percentage: 10, time: "49m")
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("주간 집중 시간")
                .font(.headline)
                .padding(.bottom, 5)

            Chart {
                ForEach(data) { item in
                    BarMark(
                        x: .value("비율", item.percentage),
                        y: .value("카테고리", item.category)
                    )
                    .foregroundStyle(getColor(for: item.category))
                }
            }
            .frame(height: 200) // 차트 높이 설정
            .chartXAxis(.hidden) // X축 숨김 (선택 사항)
            .chartYAxis {
                AxisMarks(position: .leading) // Y축 왼쪽 정렬
            }
            .padding(.horizontal)
        }
    }

    // 카테고리별 색상 지정
    private func getColor(for category: String) -> Color {
        switch category {
        case "취미": return .blue
        case "공부": return .indigo
        case "독서": return .cyan
        case "운동": return .teal
        default: return .gray
        }
    }
}


#Preview {
    BarChartView()
}
