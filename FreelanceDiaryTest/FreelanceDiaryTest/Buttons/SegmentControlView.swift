//
//  SegmentControlView.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import SwiftUI

struct SegmentControlView: View {
    var segments: [SegmentControlView.Segment]
    
    var currentSegment: SegmentControlView.Segment
    var offset: CGFloat = 2
    var padding: CGFloat = 3
    
    var select: (SegmentControlView.Segment) -> ()
    
    private var selectedIndex: Int {
        segments.firstIndex(where: {$0.id == currentSegment.id}) ?? 0
    }
    
    private let height: CGFloat = 42
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.purple.opacity(0.2))
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.purple)
                    .frame(width: geo.size.width / CGFloat(segments.count))
                    .shadow(color: .gray.opacity(0.1), radius: 2, x: 1, y: 1)
                    .animation(.spring().speed(1.5), value: currentSegment.id)
                    .offset(x: selectedIndex == 0 ? 0 : geo.size.width / CGFloat(segments.count) * CGFloat(selectedIndex) - CGFloat(selectedIndex)*offset*padding, y: 0)
                    .padding(padding)
                HStack(spacing: 0) {
                    ForEach(segments, id: \.id) { segment in
                        Text(segment.title)
                            .font(.system(size: 15))
                            .fontWeight(currentSegment.id == segment.id ? .bold : .regular)
                            .foregroundColor(currentSegment.id == segment.id ? .white : .gray)
                            .frame(width: geo.size.width / CGFloat(segments.count),
                                   height: height)
                            .background(Color.white.opacity(0.01))
                            .gesture(DragGesture(minimumDistance: 0,
                                                 coordinateSpace: .local)
                                .onEnded({ value in
                                    if value.translation.width < 0 {
                                        if selectedIndex != 0 {
                                            let count = segments.count
                                            select(segments[count - 2])
                                        }
                                    }
                                    if value.translation.width > 0 {
                                        if selectedIndex != segments.count - 1 {
                                            let count = segments.count - 1
                                            select(segments[count])
                                        }
                                    }
                                }))
                            .highPriorityGesture(
                                TapGesture()
                                    .onEnded { _ in select(segment)}
                            )
                    }
                }
            }
        }
        .frame(height: height)
        .cornerRadius(8)
    }
}

extension SegmentControlView {
    struct Segment: Identifiable {
        var id: String
        var title: LocalizedStringKey
    }
}
