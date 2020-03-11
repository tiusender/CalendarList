//
//  CalendarUtils.swift
//  CalendarList
//
//  Created by Jorge Villalobos Beato on 3/11/20.
//  Copyright © 2020 CalendarList. All rights reserved.
//

import Foundation

public struct CalendarUtils {
    
    public static func isSameDay(date1:Date, date2:Date, calendar:Calendar) -> Bool {
        return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedSame
    }
    
    public static func resetHourPart(of date:Date, calendar:Calendar) -> Date {
        return calendar.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
    }
    
    public static func getLocalizedShortWeekdaySymbols(for calendar:Calendar) -> [CalendarWeekdaySymbol] {
        let originalSymbols = calendar.veryShortWeekdaySymbols
        var localizedSymbols:[CalendarWeekdaySymbol] = []
        
        let firstWeekdayIndex = calendar.firstWeekday - 1
        
        var isWeekend = false
        
        for i in firstWeekdayIndex ..< originalSymbols.count {
            isWeekend = (i == 0 || i == 6)
            localizedSymbols.append(CalendarWeekdaySymbol(symbol: originalSymbols[i], isWeekend: isWeekend, order: i))
        }
        
        for i in 0 ..< firstWeekdayIndex {
            isWeekend = (i == 0 || i == 6)
            localizedSymbols.append(CalendarWeekdaySymbol(symbol: originalSymbols[i], isWeekend: isWeekend, order: i))
        }
        
        return localizedSymbols
    }
    
    public static func getCalendarMonthFor(year:Int, month:Int, calendar:Calendar) -> CalendarMonth {
        var comps = DateComponents()
        comps.year = year
        comps.month = month
        comps.day = 1
        
        let newDate = calendar.date(from: comps)!
        
        return getCalendarMonthFor(date: newDate, calendar: calendar)
    }
    
    public static func getCalendarMonthFor(date:Date, calendar:Calendar) -> CalendarMonth {
        var comps = DateComponents()
        comps.year = calendar.component(.year, from: date)
        comps.month = calendar.component(.month, from: date)
        comps.day = 1
        
        let newDate = calendar.date(from: comps)!
        
        var grouped:[[Date]] = [[]]
        var currentGroupIndex = 0
        var totalDaysProcessed = 0
        
        for j in calendar.range(of: .day, in: .month, for: newDate)! {
            
            let dailyDate = calendar.date(bySetting: .day, value: j, of: newDate)!
        
            if calendar.component(.weekday, from: dailyDate) == calendar.firstWeekday && totalDaysProcessed > 0 {
                currentGroupIndex += 1
                
                grouped.append([])
            }
            
            grouped[currentGroupIndex].append(dailyDate)
            
            totalDaysProcessed += 1
        }
        
        return CalendarMonth(calendar: calendar,
                             actualDate: newDate,
                             weeks: grouped)
    }
    
    public static func getCalendarMonthsFromDate(date:Date, calendar:Calendar) -> [CalendarMonth] {
        var comps = DateComponents()
        comps.year = calendar.component(.year, from: date)
        comps.month = 1
        comps.day = 1

        let newDate = calendar.date(from: comps)!

        var monthlyGroups:[CalendarMonth] = Array()

        for i in calendar.range(of: .month, in: .year, for: newDate)! {
            
            let monthlyDate = calendar.date(bySetting: .month, value: i, of: newDate)!
            monthlyGroups.append(getCalendarMonthFor(date: monthlyDate, calendar: calendar))
        }
        
        return monthlyGroups
    }
}
