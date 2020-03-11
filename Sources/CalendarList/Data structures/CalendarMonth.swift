//
//  CalendarMonth.swift
//  CalendarList
//
//  Created by Jorge Villalobos Beato on 3/11/20.
//  Copyright © 2020 CalendarList. All rights reserved.
//

import Foundation

public struct CalendarMonth {
    public var calendar:Calendar
    public var actualDate:Date
    
    public var year:Int
    public var month:Int
    
    public var key:String {
        "\(year)-\(month)"
    }
    
    public var weeks:[[Date]]
    
    public init(calendar:Calendar, actualDate:Date, weeks:[[Date]]) {
        self.calendar = calendar
        self.actualDate = actualDate
        self.weeks = weeks
        self.year = calendar.component(.year, from: actualDate)
        self.month = calendar.component(.month, from: actualDate)
    }
    
    public func nextMonth() -> CalendarMonth {
        let date = calendar.date(byAdding: .month, value: 1, to: actualDate)
        return CalendarUtils.getCalendarMonthFor(date: date!, calendar: calendar)
    }
    
    public func previousMonth() -> CalendarMonth {
        let date = calendar.date(byAdding: .month, value: -1, to: actualDate)
        return CalendarUtils.getCalendarMonthFor(date: date!, calendar: calendar)
    }
    
    public func getSurroundingMonths() -> [CalendarMonth] {
        return [
            self.previousMonth(),
            CalendarMonth(calendar: self.calendar, actualDate: self.actualDate, weeks: self.weeks),
            self.nextMonth()
        ]
    }
    
    public func monthName() -> String {
        let name = calendar.monthSymbols[month - 1]
        
        return name.prefix(1).uppercased() + name.dropFirst()
    }
    
    public func monthTitle() -> String {
        return "\(monthName()) \(year)"
    }
    
    public static func getSurroundingMonths(forDate date:Date, andCalendar calendar:Calendar) -> [CalendarMonth] {
        let calendarMonth = CalendarUtils.getCalendarMonthFor(date: date, calendar: calendar)
        return [
            calendarMonth.previousMonth(),
            calendarMonth,
            calendarMonth.nextMonth()
        ]
    }
}
