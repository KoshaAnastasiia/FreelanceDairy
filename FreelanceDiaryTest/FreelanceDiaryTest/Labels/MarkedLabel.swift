//
//  MarkedLabel.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 30.08.2024.
//

import SwiftUI

struct MarkedLabel: View {
    var title: String
    var mark: String
    var color: Color
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.white)
                .font(.system(size: 18, weight: .semibold))
                .padding(.vertical, 20)
            Spacer()
            VStack {
                Spacer()
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(color)
                    Text(mark)
                        .foregroundStyle(.white)
                        .font(.system(size: 12, weight: .semibold))
                }.frame(height: 25)
            }.frame(maxWidth: 100)
        }.padding(.leading, 20)
            .multilineTextAlignment(.leading)
            .lineLimit(5)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black.opacity(0.1), lineWidth: 1)
            ).background(Color.purple.cornerRadius(12).opacity(0.45))
    }
}

#Preview {
    MarkedLabel(title: "ff", mark: "reg", color: Color.red)
}
