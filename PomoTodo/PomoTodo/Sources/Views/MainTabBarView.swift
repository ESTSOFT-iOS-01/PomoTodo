//
//  MainTabBarView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

struct MainTabBarView: View {
  @State private var selectedTab: Tab = .Pomo
  @Environment(DIContainer.self) private var container: DIContainer
  
  var body: some View {
    TabView(selection: $selectedTab) {
      PomoView()
        .environmentObject(PomoViewModel(pomoTodoUseCase: container.pomoTodoUseCase))
        .tabItem {
          tabItemView(for: .Pomo, isSelected: selectedTab == .Pomo)
        }
        .tag(Tab.Pomo)
      
      StatisticsView()
        .tabItem {
          tabItemView(for: .Chart, isSelected: selectedTab == .Chart)
        }
        .tag(Tab.Chart)
      
      ToDoView(
        viewModel: ToDoViewModel(
          pomoTodoUseCase: container.pomoTodoUseCase
        )
      )
      .tabItem {
        tabItemView(for: .Todo, isSelected: selectedTab == .Todo)
      }
      .tag(Tab.Todo)
      
      SettingView()
        .tabItem {
          tabItemView(for: .Setting, isSelected: selectedTab == .Setting)
        }
        .tag(Tab.Setting)
      
    }
    .tint(.indigoNormal)
    .onAppear {
      setupTabBarAppearance()
      _ = container.pomoTodoUseCase.getTodayPomoDay()
    }
  }
  
  //MARK: - Funcs
  
  /// 탭바 아이템 세팅
  private func tabItemView(for currentTab: Tab, isSelected: Bool) -> some View {
    VStack {
      Image(systemName: isSelected ? currentTab.selectedIcon : currentTab.unselectedIcon)
        .environment(\.symbolVariants, .none)
        .symbolRenderingMode(.hierarchical)
        .foregroundStyle(isSelected ? .primary : .secondary)
        .scaleEffect(isSelected ? 1.1 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
      
      Text(currentTab.labelName)
        .font(.caption)
        .foregroundStyle(isSelected ? .primary : .secondary)
    }
  }
  
  /// 탭바 스타일 세팅
  private func setupTabBarAppearance() {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
  }
  
}

#Preview {
  MainTabBarView()
    .environment(DIContainer())
}
