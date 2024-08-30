//
//  CustomDatePicker.swift
//  FreelanceDiaryTest
//
//  Created by kosha on 30.08.2024.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var currentDate: Date
    @State var currentMonth: Int = 0
    
    private let days: [WeekDay] = WeekDay.weekDays
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        VStack(spacing: 35) {
            HStack {
                Button(action: backwardAction) {
                    Image(systemName: "chevron.backward.square.fill")
                        .foregroundStyle(.purple)
                }
                
                Spacer()
                Text(extraData())
                    .font(.caption)
                    .fontWeight(.semibold)
                Spacer()
                
                Button(action: forwardAction) {
                    Image(systemName: "chevron.forward.square.fill")
                        .foregroundStyle(.purple)
                }
            }.padding(.horizontal)
            
            HStack(spacing: 0) {
                ForEach(days, id: \.id) { day in
                    Text(day.day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate()) { value in
                    CardView(value: value)
                        .background(BackgroundCircle(value: value))
                        .onTapGesture { currentDate = value.date }
                }
            }
        }
        .onChange(of: currentMonth) { oldValue, newValue in
            currentDate = getCurrentMonth()
        }
    }
    
    
    @ViewBuilder
    func BackgroundCircle(value: DateValue) -> some View {
        if Calendar.current.isDateInToday(value.date) {
            Circle()
                .stroke(.purple)
                .padding(.horizontal, 8)
        }
        if Calendar.current.isDateInToday(value.date) && isSameDate(date1: value.date, date2: currentDate) {
            Circle()
                .fill(Color.gray)
            .padding(.horizontal, 8)
            Circle()
                .fill(.purple)
                .padding(.horizontal, 8)
        }
        if currentDate == value.date {
            Circle()
                .fill(Color.gray)
                .padding(.horizontal, 8)
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                    if Calendar.current.isDateInToday(value.date) {
                        Text("\(value.day)")
                            .foregroundStyle(isSameDate(date1: value.date, date2: currentDate) ? .white : .purple)
                            .frame(maxWidth: .infinity)
                        Spacer()
                    } else if Calendar.current.isDateInToday(value.date) && isSameDate(date1: value.date, date2: currentDate) {
                        Text("\(value.day)")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                    } else if currentDate == value.date {
                        Text("\(value.day)")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                        Spacer()
                    } else {
                        Text("\(value.day)")
                            .foregroundStyle(.primary)
                            .frame(maxWidth: .infinity)
                        Spacer()
                    }
                
            }
        }.padding(.vertical, 8)
            .frame(height: 40, alignment: .top)
    }
    
    private func backwardAction() {
        withAnimation {
            currentMonth -= 1
        }
    }
    
    private func forwardAction() {
        withAnimation {
            currentMonth += 1
        }
    }
    
    private func isSameDate(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    private func extraData() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        let date = formatter.string(from: currentDate)
        return date
    }
    
    private func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    
    private func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

#Preview {
    CustomDatePicker(currentDate: .constant(Date()))
}
