//
//  AddNewClientView.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import SwiftUI
import RealmSwift

struct AddNewClientView: View, TValidationProtocol {
    @Environment(\.presentationMode) var presentationMode

    @State private var name: String = ""
    @State private var cliendDescription: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var isRegular: ClientRegularity?

    @State private var isNameValid: Bool = true
    @State private var isCliendDescriptionValid: Bool = true
    @State private var isPhoneNumberValid: Bool = true
    @State private var isEmailValid: Bool = true
    @State private var isRegularValid: Bool = true

    private var invalidCharacters: String {
        "The content contains invalid characters (digits, special characters), please re-enter."
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            InformationTextField(title: "Name",
                                 text: $name,
                                 isValid: $isNameValid,
                                 placeholder: "Name",
                                 validError: invalidCharacters){}
                .padding(.top, 16)
            InformationTextField(title: "Client Description",
                                 text: $cliendDescription,
                                 isValid: $isCliendDescriptionValid,
                                 placeholder: "Client Description",
                                 validError: invalidCharacters){}
            InformationTextField(title: "Phone Number",
                                 text: $phoneNumber,
                                 isValid: $isPhoneNumberValid,
                                 placeholder: "*-***-***-****",
                                 validError: invalidCharacters){}
            InformationTextField(title: "Email",
                                 text: $email,
                                 isValid: $isEmailValid,
                                 placeholder: "Email",
                                 validError: invalidCharacters){}
            makeRegulatoryMenu()
            Spacer()
        }
        .onChange(of: name) { oldValue, newValue in
            isNameValid = isValid(name: newValue)
        }
        .onChange(of: cliendDescription) { oldValue, newValue in
            isCliendDescriptionValid = true
        }
        .onChange(of: phoneNumber) { oldValue, newValue in
            isPhoneNumberValid = isValid(number: newValue)
        }
        .onChange(of: email) { oldValue, newValue in
            isEmailValid = isValid(email: newValue)
        }
        .toolbar {
            Button("Save") {
                let clientInfo = ClientInfo()
                clientInfo.name = name
                clientInfo.cliendDescription = cliendDescription
                clientInfo.email = email
                clientInfo.phoneNumber = phoneNumber
                let realm = try! Realm()
                try? realm.write {
                    realm.add(clientInfo)
                }
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(!isReadyForNext)
        }
    }
    
    private var isReadyForNext: Bool {
        isNameValid && isCliendDescriptionValid && isPhoneNumberValid && isEmailValid &&
        !name.isEmpty && !cliendDescription.isEmpty && !phoneNumber.isEmpty && !email.isEmpty && isRegular != nil
    }

    @ViewBuilder private func makeRegulatoryMenu() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("A regular customer")
                .foregroundStyle(Color.primary)
                .font(.system(size: 16))
                .padding(.bottom, 4)
            if !isRegularValid {
                HStack(spacing: 0) {
                    Image(systemName: "exclamationmark.circle")
                        .font(.system(size: 18))
                        .foregroundStyle(Color.red)
                        .padding(.trailing, 8)
                        .padding(.horizontal, 10)
                    Text("This information is required")
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
                ForEach(ClientRegularity.allCases, id: \.self) { item in
                    Button(action: { chooseRegularity(item) }) {
                        makeRegularityButton(item)
                    }
                }
            }
        }.padding(.horizontal, 16)
            .padding(.bottom, 16)
    }
    
    @ViewBuilder private func makeRegularityButton(_ item: ClientRegularity) -> some View {
            HStack(spacing: 10) {
                ZStack {
                    if item == isRegular {
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
    
    private func chooseRegularity(_ item: ClientRegularity) {
        if item == isRegular {
            isRegular = nil
        } else {
            isRegular = item
        }
    }

}
