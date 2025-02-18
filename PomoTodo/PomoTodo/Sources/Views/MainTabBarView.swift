//
//  MainTabBarView.swift
//  PomoTodo
//
//  Created by 김도연 on 2/18/25.
//

import SwiftUI

struct MainTabBarView: View {
    @State private var selectedTab: Tab = .Pomo
    
    init() {
        setupTabBarAppearance()
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ContentView()
                .tabItem {
                    tabItemView(for: .Pomo)
                }
                .tag(Tab.Pomo)
            
            ContentView()
                .tabItem {
                    tabItemView(for: .Chart)
                }
                .tag(Tab.Chart)
            
            ContentView()
                .tabItem {
                    tabItemView(for: .Todo)
                }
                .tag(Tab.Todo)
            
            ContentView()
                .tabItem {
                    tabItemView(for: .Setting)
                }
                .tag(Tab.Setting)
        }
        .tint(.indigoNormal)
    }
    
    //MARK: - Funcs
    
    /// 탭바 아이템 세팅
    private func tabItemView(for currentTab: Tab) -> some View {
        let isSelected = selectedTab == currentTab
        
        return VStack {
            Image(systemName: isSelected ? currentTab.selectedIcon : currentTab.unselectedIcon)
                .environment(\.symbolVariants, .none)
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(isSelected ? .primary : .secondary)
                .scaleEffect(isSelected ? 1.2 : 1.0)
                .animation(.easeInOut(duration: 0.2), value: isSelected)
            
            Text(currentTab.labelName)
                .font(.caption)
                .foregroundStyle(isSelected ? .primary : .secondary)
        }
    }
    
    /// 탭바 스타일 세팅
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.selected.iconColor = .indigoNormal
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.indigoNormal]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

#Preview {
    MainTabBarView()
}
