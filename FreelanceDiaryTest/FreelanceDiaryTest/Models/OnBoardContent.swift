//
//  OnBoardModel.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import Foundation

enum OnBoardContent: String, CaseIterable {
    case firstPage
    case secondPage
}

extension OnBoardContent {
    static var first: OnBoardContent {
        return .firstPage
    }
    
    var imageName: String {
        switch self {
        case .firstPage: "onboard.first"
        case .secondPage: "onboard.second"
        }
    }
    
    var title: String {
        switch self {
        case .firstPage: "Set tasks, monitor projects, control projects!"
        case .secondPage: "Create your first project"
        }
    }
    
    var subtitle: String {
        switch self {
        case .firstPage: "The application will help you develop your Projects and monitor statistics"
        case .secondPage: "Create your first Task, write Down your tasks and goals, set a deaddqsaline, and stick to your goals."
        }
    }
    
    var buttonName: String {
        switch self {
        case .firstPage: "Next"
        case .secondPage: "Start"
        }
    }
    
    var info: String {
        switch self {
        case .firstPage, .secondPage: "Terms of use | Privacy Policy"
        }
    }
    
    func next() -> OnBoardContent? {
        switch self {
        case .firstPage: .secondPage
        case .secondPage: nil
        }
    }
}
