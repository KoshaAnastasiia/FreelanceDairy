//
//  ProjectInfoView.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 30.08.2024.
//

import SwiftUI
import RealmSwift

struct ProjectInfoView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedRealmObject var project: ProjectInfo
    @ObservedRealmObject var mainInfo: MainInfo
    
    @Binding var homeNavigationPath: [HomeDestinations]
    @State private var showClientInfoView: Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                if mainInfo.priotity == .yes {
                    Text("Priority project")
                        .font(.system(size: 20, weight: .bold))
                        .frame(height: 54)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.black.opacity(0.1), lineWidth: 1)
                        ).background(Color.red.opacity(0.45).cornerRadius(12))
                }
                makeDescriptionView(text: mainInfo.infoDescription)
                
                HStack(spacing: 0) {
                    makeOneSideRoundedLabel(title: "Deadline",
                                            isLeading: true,
                                            color: Color.gray.opacity(0.45),
                                            isBold: true)
                    makeOneSideRoundedLabel(title: makeStringFromDate(date: mainInfo.deadline),
                                            isLeading: false,
                                            color: Color.purple.opacity(0.45), 
                                            isBold: false)
                    
                }
                HStack(spacing: 0) {
                    makeOneSideRoundedLabel(title: "Difficulty",
                                            isLeading: true,
                                            color: Color.gray.opacity(0.45),
                                            isBold: true)
                    makeOneSideRoundedLabel(title: mainInfo.difficulty.rawValue,
                                            isLeading: false,
                                            color: Color.purple.opacity(0.45),
                                            isBold: false)
                    
                }
                makeTaskView(tasks: project.tasksInfo)
                makeClientView()
                makeButtonView()
                Spacer()
            }.padding(.horizontal, 24)
                .padding(.bottom, TabBarView.bottom + 50)
                .navigationTitle(mainInfo.name)
        }
    }
    
    @ViewBuilder 
    private func makeDescriptionView(text: String?) -> some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Description")
                .font(.system(size: 20, weight: .bold))
            Divider()
            Text(text ?? "")
                .font(.system(size: 20, weight: .regular))
        }.frame(maxWidth: .infinity)
            .foregroundStyle(Color.gray)
            .padding(18)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black.opacity(0.1), lineWidth: 1)
            ).background(Color.gray.opacity(0.45).cornerRadius(12))
    }
    
    @ViewBuilder
    private func makeOneSideRoundedLabel(title: String,
                                         isLeading: Bool,
                                         color: Color,
                                         isBold: Bool) -> some View {
        HStack {
            if !isLeading {
                Spacer()
            }
            VStack(alignment: isLeading ? .leading : .trailing, spacing: 0) {
                Text(title)
                    .font(.system(size: 20, weight: isBold ? .bold : .regular))
            }
            if isLeading {
                Spacer()
            }
        }.padding(18)
            .foregroundStyle(isLeading ? Color.gray : Color.white)
            .background(color)
            .cornerRadius(12, corners: isLeading ? [.topLeft, .bottomLeft] : [.topRight, .bottomRight])
    }
    
    @ViewBuilder
    private func makeTaskView(tasks: RealmSwift.List<TaskInfo>) -> some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Tasks")
                .font(.system(size: 20, weight: .bold))
            Divider()
            ForEach(tasks, id: \.id) { task in
                Text("\(task.title), Price: \(task.price)$")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black.opacity(0.1), lineWidth: 1)
                    ).background(Color.purple.opacity(0.45).cornerRadius(12))
            }
        }.frame(maxWidth: .infinity)
            .foregroundStyle(Color.gray)
            .padding(18)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black.opacity(0.1), lineWidth: 1)
            ).background(Color.gray.opacity(0.45).cornerRadius(12))
    }
    
    @ViewBuilder
    private func makeClientView() -> some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Client")
                .font(.system(size: 20, weight: .bold))
            Divider()
            if let client = project.client {
                NavigationLink(value: HomeDestinations.clientInfo(clientInfo: client)) {
                    MarkedLabel(title: client.name,
                                mark: client.isRegular.title,
                                color: client.isRegular.color)
                }
            }
        }.frame(maxWidth: .infinity)
            .foregroundStyle(Color.gray)
            .padding(18)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black.opacity(0.1), lineWidth: 1)
            ).background(Color.gray.opacity(0.45).cornerRadius(12))
    }
    
    @ViewBuilder
    private func makeButtonView() -> some View {
        HStack(spacing: 20) {
            Button(action: completeProjectAction) {
                Text(mainInfo.readiness == .completed ? "Completed" : "Complete")
                    .font(.system(size: 20, weight: .bold))
                    .frame(height: 54)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(mainInfo.readiness == .completed ? Color.white : Color.green)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.green, lineWidth: 1)
                    ).background(
                        mainInfo.readiness == .completed ? Color.green.cornerRadius(12) :  Color.white.cornerRadius(12))
                
                Button(action: deleteProjectAction) {
                    Text("Delete")
                        .font(.system(size: 20, weight: .bold))
                        .frame(height: 54)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.red, lineWidth: 1)
                        ).background(Color.red.opacity(0.65).cornerRadius(12))
                }
            }
        }
    }
    
    private func deleteProjectAction() {
        let realm = try! Realm()
        try? realm.write {
            if let mainInfo = realm.object(ofType: MainInfo.self, forPrimaryKey: mainInfo.id) {
                realm.delete(mainInfo)
            }
            if let project = realm.object(ofType: ProjectInfo.self, forPrimaryKey: project.id) {
                realm.delete(project.tasksInfo)
                realm.delete(project)
            }
        }
        presentationMode.wrappedValue.dismiss()
    }
    
    private func completeProjectAction() {
        guard mainInfo.readiness == .active else {
            return
        }
        let realm = try! Realm()
        try? realm.write {
            mainInfo.thaw()?.readiness = .completed
        }
    }
    
    
    private func makeStringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        return dateFormatter.string(from: date)
    }
}
