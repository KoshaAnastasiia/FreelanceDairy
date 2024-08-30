//
//  PrimaryLabel.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import SwiftUI

struct PrimaryLabel: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.body)
            .frame(height: 54)
            .frame(maxWidth: .infinity)
            .foregroundStyle(Color.white)
            .background(.purple)
            .cornerRadius(14)
    }
}

#Preview {
    PrimaryLabel(text: "Hello")
}
