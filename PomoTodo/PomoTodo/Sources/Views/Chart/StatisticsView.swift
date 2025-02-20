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
  @Bindable var viewModel = StatisticsViewModel
  // @State private var selectedPeriod = "주"
  // let periods = ["일", "주", "월"]
  
  let periods: [(label: String, period: StatisticsViewModel.SelectedPeriod)] = [
    ("일", .day),
    ("주", .week),
    ("월", .month)
  ]
  
  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(spacing: 24) {
          // Segmented Control
          Picker("기간 선택", selection: viewModel.state.selectedPeriod) {
            ForEach(periods, id: \.self) { period in
              Text(period.label).tag(period.period)
            }
          }
          .pickerStyle(.segmented)
          .padding(.horizontal, 24)
          .onChange(of: viewModel.state.selectedPeriod) { newPeriod in
            viewModel.send(.updatePeriod(newPeriod))
          }
          
          HStack(spacing: 8) {
            // 이전 날짜 버튼 (이전 날짜 없으면 비활성화)
            Button(action: { viewModel.send(.previousDate) }) {
              Image(systemName: "chevron.backward.circle.fill")
                .foregroundStyle(.indigo)
                .bold()
                .opacity(viewModel.getPreviousAvailableDate() == nil ? 0.5 : 1.0)
            }
            .disabled(viewModel.getPreviousAvailableDate() == nil)
            
            Text(viewModel.state.displayDate)
              .font(.system(size: 14, weight: .bold))
            
            // 다음 날짜 버튼 (다음 날짜 없으면 비활성화)
            Button(action: { viewModel.send(.nextDate) }) {
              Image(systemName: "chevron.forward.circle.fill")
                .foregroundStyle(.indigo)
                .bold()
                .opacity(viewModel.getNextAvailableDate() == nil ? 0.5 : 1.0)
            }
            .disabled(viewModel.getNextAvailableDate() == nil)
          }
          
          // 누적 포모도로 & 세션 뷰
          SectionView {
            HStack {
              VStack(alignment: .leading, spacing: 16) {
                Text("해당 \(viewModel.state.selectedPeriod)의 포모도로")
                  .font(.system(size: 13))
                // ‼️뷰모델 작성시 수정 필요
                Text("\(viewModel.state.totalPomodoro)")
                  .font(.system(size: 24, weight: .bold))
              }
              .padding(EdgeInsets(top: 13, leading: 24, bottom: 13, trailing: 0))
              
              Spacer()
              
              VStack(alignment: .leading, spacing: 16) {
                Text("해당 \(viewModel.state.selectedPeriod)의 세션")
                  .font(.system(size: 13))
                // ‼️뷰모델 작성시 수정 필요
                Text(String(format: "%.1f", viewModel.state.totalSessions))
                  .font(.system(size: 24, weight: .bold))
              }
              .padding(EdgeInsets(top: 13, leading: 24, bottom: 13, trailing: 0))
              
              Spacer()
            }
            
          }
          
          // 차트 뷰
          SectionView {
            VStack {
              HStack {
                VStack(alignment: .leading, spacing: 16) {
                  Text("\(viewModel.state.selectedPeriod)간 집중 시간")
                    .font(.system(size: 13))
                  Text("\(viewModel.state.totalFocusTime.formattedTime())")
                    .font(.system(size: 24, weight: .bold))
                }
                .padding(EdgeInsets(top: 24, leading: 24, bottom: 0, trailing: 0))
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 16) {
                  Text("누적 집중 시간")
                    .font(.system(size: 13))
                  Text("\(viewModel.state.allFocusTime.formattedTime())")
                    .font(.system(size: 24, weight: .bold))
                }
                .padding(EdgeInsets(top: 24, leading: 24, bottom: 0, trailing: 0))
                
                Spacer()
              }
              
              BarChartView(viewModel: viewModel)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 24, leading: 24, bottom: 32, trailing: 0))
            }
          }
          
          // 주간 평균 세션 & 평균 집중 시간
          SectionView {
            HStack {
              VStack(alignment: .leading, spacing: 16) {
                Text("\(viewModel.state.selectedPeriod)간 평균 세션")
                  .font(.system(size: 13))
                Text(String(format: "%.1f", viewModel.state.averageSessions))
                  .font(.system(size: 24, weight: .bold))
              }
              .padding(EdgeInsets(top: 13, leading: 24, bottom: 13, trailing: 0))
              
              Spacer()
              
              VStack(alignment: .leading, spacing: 16) {
                Text("\(viewModel.state.selectedPeriod)간 평균 집중 시간")
                  .font(.system(size: 13))
                Text("\(viewModel.state.averageFocusTime.formattedTime())")
                  .font(.system(size: 24, weight: .bold))
              }
              .padding(EdgeInsets(top: 13, leading: 24, bottom: 13, trailing: 0))
              
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
