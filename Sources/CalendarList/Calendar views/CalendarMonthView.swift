//
//  CalendarMonthView.swift
//  CalendarList
//
//  Created by Jorge Villalobos Beato on 3/11/20.
//  Copyright © 2020 CalendarList. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct CalendarMonthView<T:Hashable>: View {
    let month:CalendarMonth
    let calendar:Calendar
    
    @Binding var selectedDate:Date
    
    let calendarDayWidth:CGFloat
    let calendarDayHeight:CGFloat
    
    let eventsForDate:[Date:[CalendarEvent<T>]]
    
    let selectedDateColor:Color
    let todayDateColor:Color
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(self.month.weeks, id:\.self) { week in
                HStack(spacing: 0) {
                    if week.count < 7 && self.containsFirstDayOfMonth(week) {
                        ForEach(1 ... 7 - week.count, id:\.self) { num in
                            Text("")
                                .frame(width: self.calendarDayWidth,
                                       height: self.calendarDayHeight)
                                
                        }
                    }

                    ForEach(week, id:\.self) { day in
                        CalendarViewDay(calendar: self.calendar,
                                        day: day,
                                        selected: CalendarUtils.isSameDay(date1:self.selectedDate, date2:day, calendar: self.calendar),
                                        hasEvents: self.dayHasEvents(day),
                                        width: self.calendarDayWidth,
                                        height: self.calendarDayHeight,
                                        selectedDateColor: self.selectedDateColor,
                                        todayDateColor: self.todayDateColor)
                            .onTapGesture {
                                self.selectedDate = day
                            }
                    }

                    if week.count < 7 && !self.containsFirstDayOfMonth(week) {
                        ForEach(1 ... 7 - week.count, id:\.self) { num in
                            Text("")
                            .frame(width: self.calendarDayWidth,
                                   height: self.calendarDayHeight)
                        }
                    }
                }
                    
                .padding([.leading, .trailing], 10)
            }
        }
    }
    
    func containsFirstDayOfMonth(_ dates:[Date]) -> Bool {
        return dates.contains { (date) -> Bool in
            calendar.component(.day, from: date) == 1
        }
    }
    
    func dayHasEvents(_ date:Date) -> Bool {
        let actualDay = CalendarUtils.resetHourPart(of: date, calendar:self.calendar)
        
        if let events = self.eventsForDate[actualDay] {
            return events.count > 0
        } else {
            return false
        }
    }
}
