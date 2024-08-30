//
//  AddNewInfo.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import Foundation

struct AddNewInfo: Identifiable {
    let id = UUID().uuidString
    let imageName: String
    let title: String
    let buttonName: String
}

extension AddNewInfo {
    static var project: AddNewInfo {
        AddNewInfo(imageName: "computer.colored",
                   title: "You don't have any projects yet",
                   buttonName: "Create one now")
    }
    
    static var client: AddNewInfo {
        AddNewInfo(imageName: "client.colored",
                   title: "You have no saved clients",
                   buttonName: "Add a new client")
    }
}
