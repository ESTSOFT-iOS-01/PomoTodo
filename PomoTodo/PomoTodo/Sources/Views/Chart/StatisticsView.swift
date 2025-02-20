//
//  StatisticsView.swift
//  PomoTodo
//
//  Created by 도민준 on 2/18/25.
//

import SwiftUI
import Charts
import Combine

// MARK: - 통계 탭 전체 뷰
struct StatisticsView: View {
  @ObservedObject var viewModel: StatisticsViewModel
  
  init(viewModel: StatisticsViewModel) {
    self.viewModel = viewModel
  }
  // @State private var selectedPeriod = "주"
  let periods = ["일", "주", "월"]
  
  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(spacing: 24) {
          // Segmented Control
          // 새로운 Segmented Control 뷰 사용
          SegmentedControlView(selectedPeriod: $viewModel.selectedPeriod) {
            viewModel.send(.changePeriod(viewModel.selectedPeriod))
          }
          
          HStack(spacing: 8) {
            // 이전 날짜 버튼 (이전 날짜 없으면 비활성화)
            Button(action: {
              viewModel.send(.previousDate)
            }) {
              Image(systemName: "chevron.backward.circle.fill")
                .foregroundStyle(viewModel.isPreviousAvailable ? .indigoNormal : .indigoLightHover)
                .bold()
            }
            .disabled(!viewModel.isPreviousAvailable)
            
            Text(viewModel.displayDate)
              .font(.system(size: 14, weight: .bold))
            
            // 다음 날짜 버튼 (다음 날짜 없으면 비활성화)
            Button(action: {
              viewModel.send(.nextDate)
            }) {
              Image(systemName: "chevron.forward.circle.fill")
                .foregroundStyle(viewModel.isNextAvailable ? .indigoNormal : .indigoLightHover)
                .bold()
            }
            .disabled(!viewModel.isNextAvailable)
          }
          
          // 누적 포모도로 & 세션 뷰
          SectionView {
            HStack {
              VStack(alignment: .leading, spacing: 16) {
                Text("해당 \(viewModel.selectedPeriod)의 포모도로")
                  .font(.system(size: 13))
                // ‼️뷰모델 작성시 수정 필요
                Text("\(viewModel.totalPomodoro)")
                  .font(.system(size: 24, weight: .bold))
              }
              .padding(EdgeInsets(top: 13, leading: 24, bottom: 13, trailing: 0))
              
              Spacer()
              
              VStack(alignment: .leading, spacing: 16) {
                Text("해당 \(viewModel.selectedPeriod)의 세션")
                  .font(.system(size: 13))
                // ‼️뷰모델 작성시 수정 필요
                Text(String(format: "%.1f", viewModel.totalSessions))
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
                  Text("\(viewModel.selectedPeriod)간 집중 시간")
                    .font(.system(size: 13))
                  Text("\(viewModel.totalFocusTime.formattedTime())")
                    .font(.system(size: 24, weight: .bold))
                }
                .padding(EdgeInsets(top: 24, leading: 24, bottom: 0, trailing: 0))
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 16) {
                  Text("누적 집중 시간")
                    .font(.system(size: 13))
                  Text("\(viewModel.allFocusTime.formattedTime())")
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
                Text("\(viewModel.selectedPeriod)간 평균 세션")
                  .font(.system(size: 13))
                Text(String(format: "%.1f", viewModel.averageSessions))
                  .font(.system(size: 24, weight: .bold))
              }
              .padding(EdgeInsets(top: 13, leading: 24, bottom: 13, trailing: 0))
              
              Spacer()
              
              VStack(alignment: .leading, spacing: 16) {
                Text("\(viewModel.selectedPeriod)간 평균 집중 시간")
                  .font(.system(size: 13))
                Text("\(viewModel.averageFocusTime.formattedTime())")
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
    
    .onAppear {
          viewModel.send(.onAppear)
        }
  }
}
//
//#Preview {
//  StatisticsView(viewModel: StatisticsViewModel(pomoTodoUseCase: PomoTodoUseCaseImpl))
//}
