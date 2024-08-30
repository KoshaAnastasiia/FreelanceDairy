//
//  ClientInfoView.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 30.08.2024.
//

import SwiftUI

struct ClientInfoView: View {
    @Binding var homeNavigationPath: [HomeDestinations]
    var client: ClientInfo
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 18) {
                Text(client.name)
                    .font(.system(size: 20, weight: .bold))
                Divider()
                Text(client.isRegular.title)
                    .font(.system(size: 20, weight: .bold))
                    .frame(height: 54)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black.opacity(0.1), lineWidth: 1)
                    ).background(client.isRegular.color.opacity(0.45).cornerRadius(12))
                
                makeClientLabelView(title: "Description", info: client.cliendDescription)
                
                makeClientLabelView(title: "Phone", info: client.phoneNumber)
                
                makeClientLabelView(title: "Email", info: client.email)
                Spacer()
            }.frame(maxWidth: .infinity)
                .foregroundStyle(Color.gray)
                .padding(18)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black.opacity(0.1), lineWidth: 1)
                ).background(Color.gray.opacity(0.45).cornerRadius(12))
        }.padding(.horizontal, 24)
            .padding(.bottom, TabBarView.bottom + 50)
    }
    
    @ViewBuilder
    private func makeClientLabelView(title: String, info: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .frame(width: 80)
            Spacer()
            Rectangle()
                .frame(width: 1)
                .padding(.horizontal, 15)
            Text(info)
                .font(.system(size: 14, weight: .regular))
            Spacer()
        }.frame(maxWidth: .infinity)
            .padding(20)
            .foregroundStyle(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black.opacity(0.1), lineWidth: 1)
            ).background(Color.purple.opacity(0.45).cornerRadius(12))
    }
}
