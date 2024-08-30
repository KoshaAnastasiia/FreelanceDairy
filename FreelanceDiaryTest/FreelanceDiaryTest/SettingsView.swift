//
//  SettingsView.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import SwiftUI

struct SettingsView: View {
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Image("settings")
                .padding(.top, 100)
                .padding(.bottom, 30)
            Spacer()
            Button(action: {}) {
                PrimaryLabel(text: "Rate Us")
            }.padding(.horizontal, 30)
            
            Button(action: {}) {
                PrimaryLabel(text: "Developer’s website")
            }.padding(.horizontal, 30)
            
        }.padding(.bottom, TabBarView.bottom + 50)
    }
}

#Preview {
    SettingsView()
}
