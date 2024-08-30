//
//  TabBarView.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import SwiftUI

struct TabBarView: View {
    @State private var tabPoints : [TabBarItem: CGFloat] = [:]
    @Binding var selectedTabBarItem: TabBarItem
    
    static let bottom: CGFloat = 75
    
    private var curvePoint: CGFloat {
        if tabPoints.isEmpty {
            return 10
        } else {
            return tabPoints[selectedTabBarItem] ?? 10
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(item: .home,
                         selectedItem: selectedTabBarItem,
                         select: select(_:),
                         append: append(_:_:))
            TabBarButton(item: .statistics,
                         selectedItem: selectedTabBarItem,
                         select: select(_:),
                         append: append(_:_:))
            TabBarButton(item: .clients,
                         selectedItem: selectedTabBarItem,
                         select: select(_:),
                         append: append(_:_:))
            TabBarButton(item: .settings,
                         selectedItem: selectedTabBarItem,
                         select: select(_:),
                         append: append(_:_:))
        }
        .frame(height: Self.bottom)
        .background(Color.purple.opacity(0.09))
        .overlay(alignment: .topLeading,
                 content: {
            Circle()
                .fill(Color.primary)
                .frame(width: 12, height: 12)
                .offset(x: curvePoint - 5)
                .animation(.bouncy(duration: 0.6), value: curvePoint)
        })
    }
    
    private func select(_ item: TabBarItem) {
        selectedTabBarItem = item
    }

    private func append(_ point: CGFloat, _ item: TabBarItem) {
        if tabPoints[item] != point {
            DispatchQueue.main.async {
                tabPoints [item] = point
            }
        }
    }
}

#Preview {
    TabBarView(selectedTabBarItem: .constant(.home))
}
