//
//  ClientsView.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import SwiftUI
import RealmSwift

struct ClientsView: View {
    enum Mode {
        case view
        case createProject(info: MainInfo, tasks: [TaskInfo])
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var homeNavigationPath: [HomeDestinations]
    
    @State private var selectedClient: ClientInfo?
    
    @ObservedResults(ClientInfo.self) var clients
    let mode: Mode
    
    var body: some View {
        VStack {
            if clients.isEmpty {
                AddNewLabel(item: AddNewInfo.client)
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(clients) { client in
                        switch mode {
                        case .view:
                            NavigationLink(value: HomeDestinations.clientInfo(clientInfo: client)) {
                                MarkedLabel(title: client.name,
                                            mark: client.isRegular.title,
                                            color: client.isRegular.color)
                                        .padding(.horizontal, 24)
                                        .padding(.bottom, 24)
                            }
                        case .createProject(let info, let tasks):
                            MarkedLabel(title: client.name,
                                        mark: client.isRegular.title,
                                        color: client.isRegular.color)
                            .overlay(
                                client == selectedClient ?         RoundedRectangle(cornerRadius: 8)
                                    .stroke(.red, lineWidth: 3) : nil
                            )
                            .padding(.horizontal, 24)
                            .padding(.bottom, 24)
                            .onTapGesture {
                                if client == selectedClient {
                                    selectedClient = nil
                                } else {
                                    selectedClient = client
                                }
                            }

                        }
                    }
                }.padding(.top, 50)
            }
            Spacer()
            NavigationLink(value: HomeDestinations.addClient) {
                PrimaryLabel(text: AddNewInfo.client.buttonName)
                    .padding(.horizontal, 120)
            }
            Spacer()
        }.padding(.bottom, TabBarView.bottom)
            .toolbar {
                if case .createProject(let info, let tasks) = mode {
                    Button("Save") {
                        let projectInfo = ProjectInfo()
                        projectInfo.mainInfo = info
                        projectInfo.tasksInfo.append(objectsIn: tasks)
                        let realm = try! Realm()
                        let client = realm.objects(ClientInfo.self).first(where: { $0.id == selectedClient?.id })
                        try? realm.write {
                            realm.add(projectInfo)
                            projectInfo.client = client
                        }
                        homeNavigationPath = []
                    }
                    .disabled(!isReadyToSave)
                }
            }
    }
    
    var isReadyToSave: Bool {
        selectedClient != nil
    }
}

#Preview {
    ClientsView(homeNavigationPath: .constant([]), mode: .view)
}
