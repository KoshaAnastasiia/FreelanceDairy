//
//  TabBarContainerView.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import SwiftUI
import Observation

struct TabBarContainerView: View {
    @State private var selectedTabBarItem: TabBarItem = .home
    @State private var homeNavigationPath: [HomeDestinations] = []
    @State private var clientsNavigationPath: [HomeDestinations] = []

    var body: some View {
        VStack {
            switch selectedTabBarItem {
            case .home:
                NavigationStack(path: $homeNavigationPath) {
                    HomeContainerView(homeNavigationPath: $homeNavigationPath)
                }
            case .statistics:
                StatisticsView()
            case .clients:
                NavigationStack {
                    ClientsView(homeNavigationPath: $clientsNavigationPath, mode: .view)
                        .navigationDestination(for: HomeDestinations.self) { destination in
                            if case .addClient = destination {
                                AddNewClientView()
                            }
                            if case let .clientInfo(clientInfo) = destination {
                                ClientInfoView(homeNavigationPath: $clientsNavigationPath, client: clientInfo)
                            }
                        }
                }
            case .settings:
                SettingsView()
            }
        }.animation(.none, value: selectedTabBarItem)
            .ignoresSafeArea(edges: .bottom)
            .overlay(alignment: .bottom) {
                TabBarView(selectedTabBarItem: $selectedTabBarItem)
            }
    }
}

#Preview {
    TabBarContainerView()
}
