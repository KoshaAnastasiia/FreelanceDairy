//
//  ValidatorProtocol.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 29.08.2024.
//

import SwiftUI

protocol TValidationProtocol {}

extension TValidationProtocol {
    func isValid(date: String) -> Bool {
        let strategy = Date.ParseStrategy(format: "\(day: .twoDigits)/\(month: .twoDigits)/\(year: .defaultDigits)",
                                          timeZone: .current)
        guard let _ = date.range(of: #"^\d{2}.\d{2}.\d{5}$"#, options: .regularExpression),
              let validDate = try? Date(date, strategy: strategy) else {
            return false
        }
        
//        let calendar = Calendar.current
//        guard calendar.compare(.now, to: validDate, toGranularity: .day) != .orderedDescending else {
//            return false
//        }
//        return true
        guard validDate > .now else {
            return false
        }
        return true
    }
    
    func isValid(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        
        return result
    }
    
    func isValid(name: String) -> Bool {
        let regex = "[A-Za-z]{2,}"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = test.evaluate(with: name)
        return result
    }
    
    func isValid(number: String) -> Bool {
        let numberRegEx = "+^\\d{3}-\\d{3}-\\d{4}$"
        let numberTest = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let result = numberTest.evaluate(with: number)
        return result
    }
    

}
