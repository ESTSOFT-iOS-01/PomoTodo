//
//  StatisticsView.swift
//  PomoTodo
//
//  Created by 도민준 on 2/18/25.
//

import SwiftUI
import Charts

// MARK: - 통계 탭 전체 뷰
struct StatisticsView: View {
  @State private var selectedPeriod = "주"
  let periods = ["일", "주", "월"]
  
  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(spacing: 24) {
          // Segmented Control
          Picker("기간 선택", selection: $selectedPeriod) {
            ForEach(periods, id: \.self) { period in
              Text(period).tag(period)
            }
          }
          .pickerStyle(.segmented)
          .padding(.horizontal, 24)
          
          // 날짜 Text 및 날짜 선택 버튼
          HStack(spacing: 8) {
            // 이전 날짜 버튼
            Button {
              print("이전 날짜")
            } label: {
              Image(systemName: "chevron.backward.circle.fill")
                .foregroundStyle(.indigoDark)
                .bold()
            }
            
            //날짜  ‼️임의 고정값임 데이터랑 연결 필요‼️
            Text("2025년 2월 2주")
              .font(.system(size: 14, weight: .bold))
            
            // 다음 날짜 버튼
            Button {
              print("이전 날짜")
            } label: {
              Image(systemName: "chevron.forward.circle.fill")
                .foregroundStyle(.indigoDark)
                .bold()
            }
          }
          
          // 누적 포모도로 & 세션 뷰
          SectionView {
            HStack {
              VStack(alignment: .leading, spacing: 16) {
                Text("누적 포모도로")
                  .font(.system(size: 13))
                // ‼️뷰모델 작성시 수정 필요
                Text("18")
                  .font(.system(size: 24, weight: .bold))
              }
              .padding(.top, 13)
              .padding(.bottom, 13)
              .padding(.leading, 24)
              
              Spacer()
              
              VStack(alignment: .leading, spacing: 16) {
                Text("누적 세션")
                  .font(.system(size: 13))
                // ‼️뷰모델 작성시 수정 필요
                Text("18")
                  .font(.system(size: 24, weight: .bold))
              }
              .padding(.top, 13)
              .padding(.bottom, 13)
              .padding(.leading, 24)
              
              Spacer()
            }
            
          }
          
          // 차트 뷰
          SectionView {
            VStack {
              HStack {
                VStack(alignment: .leading, spacing: 16) {
                  Text("주간 집중 시간")
                    .font(.system(size: 13))
                  // ‼️뷰모델 작성시 수정 필요
                  Text("12h 24m")
                    .font(.system(size: 24, weight: .bold))
                }
                .padding(.top, 24)
                .padding(.leading, 24)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 16) {
                  Text("누적 집중 시간")
                    .font(.system(size: 13))
                  // ‼️뷰모델 작성시 수정 필요
                  Text("12h 24m")
                    .font(.system(size: 24, weight: .bold))
                }
                .padding(.top, 24)
                .padding(.leading, 24)
                
                Spacer()
              }
              
              BarChartView(pomoDay: samplePomoDay)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 32)
                .padding(.leading, 24)
                .padding(.bottom, 32)
            }
          }
          
          // 주간 평균 세션 & 평균 집중 시간
          SectionView {
            HStack {
              VStack(alignment: .leading, spacing: 16) {
                Text("주간 평균 세션")
                  .font(.system(size: 13))
                // ‼️뷰모델 작성시 수정 필요
                Text("18")
                  .font(.system(size: 24, weight: .bold))
              }
              .padding(.top, 13)
              .padding(.bottom, 13)
              .padding(.leading, 24)
              
              Spacer()
              
              VStack(alignment: .leading, spacing: 16) {
                Text("주간 평균 집중 시간")
                  .font(.system(size: 13))
                // ‼️뷰모델 작성시 수정 필요
                Text("26.5")
                  .font(.system(size: 24, weight: .bold))
              }
              .padding(.top, 13)
              .padding(.bottom, 13)
              .padding(.leading, 24)
              
              Spacer()
            }
            
          }
          
        }
      }
      .navigationTitle("통계")
    }
  }
}

#Preview {
  StatisticsView()
}
