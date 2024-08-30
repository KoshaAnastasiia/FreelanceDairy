//
//  AddNewLabel.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import SwiftUI

struct AddNewLabel: View {
    var item: AddNewInfo
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack {
                Color.white
                    .frame(height: 290)
                Image(item.imageName)
            }
            .padding(.top, 100)
            .padding(.bottom, 30)
            Text(item.title)
                .font(.system(size: 18).bold())
                .foregroundStyle(Color.black)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
        }
    }
}

#Preview {
    AddNewLabel(item: AddNewInfo.client)
}
