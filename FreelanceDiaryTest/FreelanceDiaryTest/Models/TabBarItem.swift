//
//  TabBarItem.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import Foundation
import SwiftUI

enum TabBarItem: CaseIterable {
    case home
    case statistics
    case clients
    case settings
}

extension TabBarItem {
    var imageName: String {
        switch self {
        case .home:
            return "house"
        case .statistics:
            return "chart.bar"
        case .clients:
            return "person"
        case .settings:
            return "checklist.unchecked"
        }
    }
    
    var title: LocalizedStringKey {
        switch self {
        case .home:
            return "Home"
        case .statistics:
            return "Statistics"
        case .clients:
            return "Clients"
        case .settings:
            return "Settings"
        
        }
    }
}
