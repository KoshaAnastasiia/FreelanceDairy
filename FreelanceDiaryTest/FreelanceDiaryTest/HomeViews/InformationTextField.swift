//
//  InformationTextField.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import SwiftUI

struct InformationTextField: View {
    var title: String
    @Binding var text: String
    @Binding var isValid: Bool
    var placeholder: String
    var validError: String
    
    var icon: String?
    var isShouldShow: Bool = false
    var showAction: () -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .foregroundStyle(Color.primary)
                .font(.system(size: 16))
                .padding(.bottom, 4)
            HStack {
                TextField("",
                          text: $text)
                .padding(.leading, 17)
                .padding(.vertical, 8)
                .keyboardType(.alphabet)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .placeholder(when: text.isEmpty,
                             alignment: .leading) {
                    Text(placeholder)
                        .font(.system(size: 14))
                            .foregroundStyle(Color.gray.opacity(0.2))
                }
                if !isValid {
                    Image(systemName: "exclamationmark.circle")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.red)
                        .padding(.trailing, 8)
                }
                if isShouldShow {
                    Button(action: showAction) {
                        if let icon = icon {
                            Image(systemName: icon)
                                .foregroundStyle(.purple)
                        }
                    } .padding(.trailing, 8)
                }
            }
            .font(.system(size: 14))
            .multilineTextAlignment(.leading)
            .overlay(RoundedRectangle(cornerRadius: 4)
                .stroke(isValid ? Color.gray : Color.red,
                        lineWidth: 1))
            if !isValid {
                Text(validError)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.red)
                    .padding(.top, 4)
            }
        }.padding(.horizontal, 16)
            .padding(.bottom, 16)
    }
}

#Preview {
    InformationTextField(title: "Name",
                         text: .constant(""),
                         isValid: .constant(true),
                         placeholder: "Name",
                         validError: "Error"){}
}
