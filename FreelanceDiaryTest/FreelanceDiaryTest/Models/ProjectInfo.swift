//
//  ProjectInfo.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import Foundation
import RealmSwift
import SwiftUI

class MainInfo: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var name: String
    @Persisted var infoDescription: String
    @Persisted var deadline: Date
    @Persisted var priotity: ProjectPriority
    @Persisted var difficulty: ProjectDifficulty
    @Persisted var readiness: Readiness = .active
}

enum Readiness: String, CaseIterable, PersistableEnum {
    case active
    case completed
}

class TaskInfo: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var title: String
    @Persisted var price: String
}

class ClientInfo: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var name: String
    @Persisted var cliendDescription: String
    @Persisted var phoneNumber: String
    @Persisted var email: String
    @Persisted var isRegular: ClientRegularity
}

class ProjectInfo: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var mainInfo: MainInfo?
    @Persisted var tasksInfo: RealmSwift.List<TaskInfo>
    @Persisted var client: ClientInfo?
}

enum ProjectPriority: String, CaseIterable, PersistableEnum {
    case yes = "Yes"
    case no = "No"
}

enum ClientRegularity: String, CaseIterable, PersistableEnum {
    case yes = "Yes"
    case no = "No"
}

extension ClientRegularity {
    var color: Color {
        switch self {
        case .yes: Color.green.opacity(0.7)
        case .no: Color.red.opacity(0.7)
        }
    }
    
    var title: String {
        switch self {
        case .yes: "Regular"
        case .no: "Custom"
        }
    }
}

enum ProjectDifficulty: String, CaseIterable, PersistableEnum {
    case easy = "Eazy"
    case medium = "Medium"
    case hard = "Hard"
}

extension ProjectDifficulty {
    var segments: [SegmentControlView.Segment] {
        return Self.allCases.map({ $0.segment })
    }

    var segment: SegmentControlView.Segment {
        return .init(id: self.rawValue,
                     title: LocalizedStringKey(stringLiteral: self.rawValue))
    }
}
