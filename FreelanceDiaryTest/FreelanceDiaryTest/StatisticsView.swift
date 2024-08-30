//
//  StatisticsView.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import SwiftUI
import RealmSwift

struct StatisticsView: View {
    @ObservedResults(ProjectInfo.self) var projects
    @ObservedResults(ClientInfo.self) var clients

    private var totalMoney: Double {
        projects.reduce(0 as Double) { partialResult, project in
            partialResult + project.tasksInfo.reduce(0 as Double) { partialResult, task in
                partialResult + (Double(task.price) ?? 0)
            }
        }
    }
    
    private var totalCompleted: Int {
        projects.filter { $0.mainInfo?.readiness == .completed }.count
    }
    
    private var totalClients: Int {
        clients.count
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                makeOneSideRoundedLabel(title: "Earn for all time",
                                        isLeading: true,
                                        color: Color.gray.opacity(0.45),
                                        isBold: true)
                makeOneSideRoundedLabel(title: "\(totalMoney)",
                                        isLeading: false,
                                        color: Color.purple.opacity(0.45),
                                        isBold: false)
            }
            .fixedSize(horizontal: false, vertical: true)

            HStack(spacing: 0) {
                makeOneSideRoundedLabel(title: "Completed for all time",
                                        isLeading: true,
                                        color: Color.gray.opacity(0.45),
                                        isBold: true)
                makeOneSideRoundedLabel(title: "\(totalCompleted)",
                                        isLeading: false,
                                        color: Color.purple.opacity(0.45),
                                        isBold: false)
            }
            .fixedSize(horizontal: false, vertical: true)
            HStack(spacing: 0) {
                makeOneSideRoundedLabel(title: "Number of client for all time",
                                        isLeading: true,
                                        color: Color.gray.opacity(0.45),
                                        isBold: true)
                makeOneSideRoundedLabel(title: "\(totalClients)",
                                        isLeading: false,
                                        color: Color.purple.opacity(0.45),
                                        isBold: false)
                
            }
            .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
        .padding(.bottom, TabBarView.bottom)
        .padding(.horizontal, 20)
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
            .frame(maxHeight: .infinity)
            .foregroundStyle(isLeading ? Color.gray : Color.white)
            .background(color)
            .cornerRadius(12, corners: isLeading ? [.topLeft, .bottomLeft] : [.topRight, .bottomRight])
    }

}

#Preview {
    StatisticsView()
}
