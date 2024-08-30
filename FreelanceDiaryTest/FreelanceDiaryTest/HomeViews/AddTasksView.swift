//
//  AddTasksView.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import SwiftUI

struct AddTasksView: View, TValidationProtocol {
    let mainInfo: MainInfo
    @Binding var homeNavigationPath: [HomeDestinations]
    
    @State private var title: String = ""
    @State private var price: String = ""
    
    @State private var isTitleValid: Bool = true
    @State private var isPriceValid: Bool = true

    @State var tasks: [TaskInfo] = []
    
    var body: some View {
        List {
            ForEach(tasks) { task in
                taskCell(task: task)
            }
            addCell()
        }
        .onChange(of: title) { oldValue, newValue in
            isTitleValid = true
        }
        .onChange(of: price) { oldValue, newValue in
            isPriceValid = newValue.isEmpty || Double(newValue) != nil
        }
        .navigationTitle("Tasks")
        .toolbar {
            NavigationLink(value: HomeDestinations.clientsView(mainInfo: mainInfo, tasks: tasks)) {
                Text("Next")
            }.disabled(!isReadyForNext)
        }
    }
    
    @ViewBuilder private func taskCell(task: TaskInfo) -> some View {
        VStack {
            Text("Title: \(task.title)")
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                )
            Text("Price: \(task.price)")
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                )
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.purple)
        )
    }

    @ViewBuilder private func addCell() -> some View {
        VStack {
            InformationTextField(title: "Title",
                                 text: $title,
                                 isValid: $isTitleValid,
                                 placeholder: "Title",
                                 validError: "Empty"){}
            .frame(maxWidth: .infinity)
            InformationTextField(title: "Price",
                                 text: $price,
                                 isValid: $isPriceValid,
                                 placeholder: "Price",
                                 validError: "Should be number"){}
            .frame(maxWidth: .infinity)
            Button("Add new task") {
                let taskInfo = TaskInfo()
                taskInfo.title = title
                taskInfo.price = price
                tasks.append(taskInfo)
                title = ""
                price = ""
            }
            .disabled(!canAdd)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
            )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.purple.opacity(0.2))
        )
    }
    private var isReadyForNext: Bool {
        !tasks.isEmpty
    }
    
    private var canAdd: Bool {
        isTitleValid && isPriceValid && !title.isEmpty && !price.isEmpty
    }
}
