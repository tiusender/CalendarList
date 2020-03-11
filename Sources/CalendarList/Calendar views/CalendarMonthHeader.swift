//
//  CalendarMonthHeader.swift
//  CalendarList
//
//  Created by Jorge Villalobos Beato on 3/11/20.
//  Copyright © 2020 CalendarList. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct CalendarMonthHeader:View {
    let calendar:Calendar
    let calendarDayWidth:CGFloat
    let calendarDayHeight:CGFloat
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(CalendarUtils.getLocalizedShortWeekdaySymbols(for: self.calendar), id:\.order) { weekdaySymbol in
                Text("\(weekdaySymbol.symbol)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(!weekdaySymbol.isWeekend ? Color.primary : Color.secondary)
                    .frame(width: self.calendarDayWidth,
                           height: self.calendarDayHeight/2)
                    
            }
        }
    }
}
