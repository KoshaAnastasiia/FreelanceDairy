//
//  AllProjectsView.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import SwiftUI
import RealmSwift

struct AllProjectsView: View {
    @AppStorage("project.type") private var projectType = ProjectType.active

    @Binding var homeNavigationPath: [HomeDestinations]
    @ObservedResults(ProjectInfo.self) var projects

    @State private var showProgectInfoView: Bool = false
    
    var body: some View {
        VStack {
            if projects.isEmpty {
                AddNewLabel(item: AddNewInfo.project)
            } else {
                makeProjectsView()
            }
            
            Spacer()
            NavigationLink(value: HomeDestinations.addNewProject) {
                PrimaryLabel(text: AddNewInfo.project.buttonName)
                    .padding(.horizontal, 120)
            }
            Spacer()
        }.padding(.bottom, TabBarView.bottom)
    }
    
    @ViewBuilder private func makeProjectsView() -> some View {
        VStack(spacing: 0) {
            SegmentControlView(segments: projectType.segments,
                               currentSegment: projectType.segment,
                               select: { segment in
                if let type = ProjectType(rawValue: segment.id) {
                    projectType = type
                }
            })
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity)
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading,
                           spacing: 20) {
                    ForEach(
                        projects.filter({ project in
                            switch projectType {
                            case .active:
                                return project.mainInfo?.readiness == .active
                            case .completed:
                                return project.mainInfo?.readiness == .completed
                            }
                        }),
                        id: \.id
                    ) { project in
                        makeProjectRowView(project: project)
                    }
                }.padding(.top, 24)
            }
        }
    }
    
    @ViewBuilder private func makeProjectRowView(project: ProjectInfo) -> some View {
        NavigationLink(value: HomeDestinations.projectInfo(projectInfo: project)) {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(project.mainInfo?.name ?? "")
                    Text(makeStringFromDate(date: project.mainInfo?.deadline ?? .now))
                }
                Spacer()
                Text("Tasks: \(project.tasksInfo.count)")
            }.padding(20)
                .font(.system(size:  18, weight: .semibold))
                .foregroundStyle(.gray)
                .multilineTextAlignment(.leading)
                .lineLimit(5)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black.opacity(0.1), lineWidth: 1)
                ).background(Color.white.cornerRadius(12))
        }
        .padding(.horizontal, 24)
    }

    
    private func makeStringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        return dateFormatter.string(from: date)
    }
    
    enum ProjectType: String, CaseIterable {
        case active = "Active"
        case completed = "Completed"
    }
}

#Preview {
    AllProjectsView(homeNavigationPath: .constant([]))
}

extension AllProjectsView.ProjectType {
    var segments: [SegmentControlView.Segment] {
        return Self.allCases.map({ $0.segment })
    }

    var segment: SegmentControlView.Segment {
        return .init(id: self.rawValue,
                     title: LocalizedStringKey(stringLiteral: self.rawValue))
    }

    
}
