//
//  OnBoardingView.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import SwiftUI

struct OnBoardingView: View {
    @AppStorage("onboard.show") private var onboardShow = true
    @State private var content: OnBoardContent = .firstPage
    @State private var showPrivacyPolicy: Bool = false
    @State private var showTabBarContainerView: Bool = false
    private var pageItem: [OnBoardContent] = OnBoardContent.allCases
    
    var body: some View {
        VStack {
            TabView(selection: $content) {
                ForEach(pageItem, id: \.self) { item in
                    makeOnboardPage(item: content)
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            makeButtons(item: content)
        }.padding(.bottom, 30)
            .popover(isPresented: $showPrivacyPolicy) {
                VStack {
                    Text(content.info)
                        .font(.system(size: 16))
                        .foregroundStyle(.red)
                }
            }
            .navigationDestination(isPresented: $showTabBarContainerView) {
                TabBarContainerView()
            }
    }
    
    @ViewBuilder private func makeOnboardPage(item: OnBoardContent) -> some View {
        VStack(alignment: .center, spacing: 30) {
            ZStack {
                Color.white
                    .frame(height: 380)
                Image(item.imageName)
            }
            .padding(.top, 30)
            Text(item.title)
                .font(.title)
                .foregroundStyle(Color.black)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .padding(.horizontal, 30)
            Text(item.subtitle)
                .font(.subheadline)
                .foregroundStyle(Color.gray)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .padding(.horizontal, 40)
            Spacer()
        }
    }
    
    @ViewBuilder private func makeButtons(item: OnBoardContent) -> some View {
        VStack {
            Button(action: continueAction) {
                PrimaryLabel(text: item.buttonName)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 10)
            Button(action: showPrivacyPolicyView) {
                Text(item.info)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.gray)
            }
        }
    }
    
    private func continueAction() {
        withAnimation {
            if let next = content.next() {
                content = next
            } else {
                onboardShow = false
            }
        }
    }
    
    private func showPrivacyPolicyView() {
        showPrivacyPolicy = true
    }
}

#Preview {
    OnBoardingView()
}
