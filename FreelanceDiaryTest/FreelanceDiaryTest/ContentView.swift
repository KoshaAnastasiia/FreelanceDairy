//
//  ContentView.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboard.show") private var onboardShow = true
    
    var body: some View {
        if onboardShow {
            OnBoardingView()
        } else {
            TabBarContainerView()
                .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    ContentView()
}
