//
//  AddNewProjectView.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import SwiftUI

struct AddNewProjectView: View, TValidationProtocol {
    @Binding var homeNavigationPath: [HomeDestinations]

    @State private var projectName: String = ""
    @State private var projectDescription: String = ""
    @State private var deadline: String = ""
    
    @State private var selectedPriority: ProjectPriority? = nil
    
    @State private var isProjectNameValid: Bool = true
    @State private var isProjectDescriptionValid: Bool = true
    @State private var isDeadlineValid: Bool = true
    @State private var isPriorityValid: Bool = true
    
    @State var selectedDate: Date = Date()
    @State private var isCalendarShowing: Bool = false
    
    @State private var projectDifficulty = ProjectDifficulty.easy
        
    private var priorities: [ProjectPriority] { ProjectPriority.allCases }
    
    private var invalidCharacters: String {
        "The content contains invalid characters (digits, special characters), please re-enter."
    }
    
    private var requiredInfo: String {
        "This information is required"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            InformationTextField(title: "Project Name",
                                 text: $projectName,
                                 isValid: $isProjectNameValid,
                                 placeholder: "Enter name of project",
                                 validError: invalidCharacters){}
                .padding(.top, 16)
            InformationTextField(title: "Project Description",
                                 text: $projectDescription,
                                 isValid: $isProjectDescriptionValid,
                                 placeholder: "Enter project description",
                                 validError: invalidCharacters){}
            InformationTextField(title: "Deadline",
                                 text: $deadline,
                                 isValid: $isDeadlineValid,
                                 placeholder: "dd.mm.yyyy",
                                 validError: invalidCharacters,
                                 icon: "calendar",
                                 isShouldShow: true) {isCalendarShowing = true}
            makePriorityMenu()
            SegmentControlView(segments: projectDifficulty.segments,
                               currentSegment: projectDifficulty.segment,
                               padding: 1,
                               select: { segment in
                if let type = ProjectDifficulty(rawValue: segment.id) {
                    projectDifficulty = type
                }
            })
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            Spacer()
        }.background(RoundedRectangle(cornerRadius: 8)
            .fill(Color.white))
        .onChange(of: projectName) { oldValue, newValue in
            if isValid(name: newValue) {
                self.isProjectNameValid = true
            } else {
                self.isProjectNameValid = false
            }
        }
        .onChange(of: projectDescription) { oldValue, newValue in
            if isValid(name: newValue) {
                self.isProjectDescriptionValid = true
            } else {
                self.isProjectDescriptionValid = false
            }
        }
        .onChange(of: deadline) { oldValue, newValue in
            if !isValid(date: newValue) && makeDateFromString(string: newValue) != nil {
                self.isDeadlineValid = true
            } else {
                self.isDeadlineValid = false
            }
        }
        .onChange(of: selectedPriority) { oldValue, newValue in
            if newValue != nil {
                self.isPriorityValid = true
            } else {
                self.isPriorityValid = false
            }
        }
        .onChange(of: selectedDate) { oldValue, newValue in
            if let deadline = makeStringFromDate(date: newValue) {
                self.deadline = deadline
            }
        }
        .popover(isPresented: $isCalendarShowing, content: {
            CustomDatePicker(currentDate: $selectedDate)
                .presentationDetents([.fraction(0.65), .large])
                .presentationDragIndicator(.visible)
        })
        .navigationTitle("Add New Project")
        .toolbar {
            NavigationLink(value: HomeDestinations.addTasks(mainInfo: mainInfo)) {
                Text("Next")
            }.disabled(!isReadyForNext)
        }
    }
    
    private var mainInfo: MainInfo {
        let mainInfo = MainInfo()
        mainInfo.name = projectName
        mainInfo.infoDescription = projectDescription
        if let deadline = makeDateFromString(string: deadline) {
            mainInfo.deadline = deadline
        }
        if let priority = selectedPriority {
            mainInfo.priotity = priority
        }
        return mainInfo
    }
    
    private var isReadyForNext: Bool {
        isProjectNameValid && isProjectDescriptionValid && isDeadlineValid && isPriorityValid &&
        !projectName.isEmpty && !projectDescription.isEmpty && !deadline.isEmpty && selectedPriority != nil
    }
    
    @ViewBuilder private func makePriorityMenu() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Priority")
                .foregroundStyle(Color.primary)
                .font(.system(size: 16))
                .padding(.bottom, 4)
            if !isPriorityValid {
                HStack(spacing: 0) {
                    Image(systemName: "exclamationmark.circle")
                        .font(.system(size: 18))
                        .foregroundStyle(Color.red)
                        .padding(.trailing, 8)
                        .padding(.horizontal, 10)
                    Text(requiredInfo)
                        .font(.system(size: 14))
                        .foregroundStyle(Color.gray)
                        
                        .padding(.vertical, 9.5)
                    Spacer()
                }.overlay(RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.red,
                            lineWidth: 1))
                .padding(.bottom, 9.5)
            }
            HStack(spacing: 15) {
                ForEach(priorities, id: \.self) { item in
                    Button(action: { choosePriority(item) }) {
                        makePriorityButton(item)
                    }
                }
            }
        }.padding(.horizontal, 16)
            .padding(.bottom, 16)
    }
    
    @ViewBuilder private func makePriorityButton(_ item: ProjectPriority) -> some View {
            HStack(spacing: 10) {
                ZStack {
                    if item == selectedPriority {
                        Circle()
                            .fill(Color.purple)
                    } else {
                        Circle()
                            .fill(Color.white)
                    }
                    Circle()
                        .stroke(Color.gray)
                }.frame(width: 20, height: 20)
                Text(item.rawValue)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.primary)
                Spacer()
                
            }
    }
    
    private func choosePriority(_ item: ProjectPriority) {
        if item == selectedPriority {
            selectedPriority = nil
        } else {
            selectedPriority = item
        }
    }
    
    private func makeDateFromString(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        return dateFormatter.date(from: string)
    }
    
    private func makeStringFromDate(date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    AddNewProjectView(homeNavigationPath: .constant([]))
}
