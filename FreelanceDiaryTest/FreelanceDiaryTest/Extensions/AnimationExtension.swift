//
//  AnimationExtension.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import SwiftUI

extension Animation {
    static var ripple: Animation {
        Animation.spring(dampingFraction: 0.5, blendDuration: 1.4)
            .speed(1.2)
    }

    static var curved: Animation {
        Animation.timingCurve(0.22, 0.34, 0, 0.8, duration: 0.5)
    }
}
