//
//  HomeContainerView.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import SwiftUI

enum HomeDestinations: Hashable {
    case addNewProject
    case addTasks(mainInfo: MainInfo)
    case clientsView(mainInfo: MainInfo, tasks: [TaskInfo])
    case addClient
    case projectInfo(projectInfo: ProjectInfo)
    case clientInfo(clientInfo: ClientInfo)
}

struct HomeContainerView: View {
    @Binding var homeNavigationPath: [HomeDestinations]
    
    var body: some View {
        AllProjectsView(homeNavigationPath: $homeNavigationPath)
            .navigationDestination(for: HomeDestinations.self) { destination in
                switch destination {
                case .addNewProject:
                    AddNewProjectView(homeNavigationPath: $homeNavigationPath)
                case let .addTasks(mainInfo):
                    AddTasksView(mainInfo: mainInfo, homeNavigationPath: $homeNavigationPath)
                case let .clientsView(mainInfo, tasks):
                    ClientsView(homeNavigationPath: $homeNavigationPath, mode: .createProject(info: mainInfo, tasks: tasks))
                case .addClient:
                    AddNewClientView()
                case let .projectInfo(projectInfo):
                    if let mainInfo = projectInfo.mainInfo {
                        ProjectInfoView(project: projectInfo, mainInfo: mainInfo, homeNavigationPath: $homeNavigationPath)
                    }
                case let .clientInfo(clientInfo):
                    ClientInfoView(homeNavigationPath: $homeNavigationPath, client: clientInfo)
                }
            }
    }
}

#Preview {
    HomeContainerView(homeNavigationPath: .constant([]))
}
