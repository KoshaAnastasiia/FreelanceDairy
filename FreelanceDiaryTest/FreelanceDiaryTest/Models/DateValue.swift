//
//  DateValue.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 30.08.2024.
//

import SwiftUI

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}

struct WeekDay: Identifiable {
    var id = UUID().uuidString
    var day: String
    
}

extension WeekDay {
    static var weekDays: [WeekDay] {
        [WeekDay(day: "S"),
         WeekDay(day: "M"),
         WeekDay(day: "T"),
         WeekDay(day: "W"),
         WeekDay(day: "T"),
         WeekDay(day: "F"),
         WeekDay(day: "s")]
    }
}
