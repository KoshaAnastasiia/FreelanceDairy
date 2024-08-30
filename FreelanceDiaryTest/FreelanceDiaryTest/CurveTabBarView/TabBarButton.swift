//
//  TabBarButton.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import SwiftUI

struct TabBarButton: View {
    var item: TabBarItem
    var selectedItem: TabBarItem
    let select: (TabBarItem) -> ()
    let append: (CGFloat, TabBarItem) -> ()
    
    private var isActive: Bool {
        selectedItem == item
    }
    
    var body: some View {
        GeometryReader{ reader -> AnyView in
            append(reader.frame(in: .global).midX, item)
            return AnyView(
                Button(action: {select(item)}) {
                    VStack(alignment: .center, spacing: 5) {
                        Image(systemName: item.imageName)
                            .renderingMode(.template)
                            .offset(y: isActive ? -1 : 0)
                        Text(item.title)
                            .font(.system(size: 9))
                    }.foregroundStyle(isActive ? Color.primary : Color.gray)
                        .background(Color.purple.opacity(0.03))
                        .frame(height: TabBarView.bottom)
                        .frame(maxWidth: .infinity)
                        .animation(.curved, value: isActive)
                }
            )
        }
    }
}

#Preview {
    TabBarButton(item: .home,
                 selectedItem: .home,
                 select: {_ in },
                 append: {_,_  in})
}
