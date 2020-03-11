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
    let calendarDayHeight:CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ForEach(CalendarUtils.getLocalizedShortWeekdaySymbols(for: self.calendar), id:\.order) { weekdaySymbol in
                        Text("\(weekdaySymbol.symbol)")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(!weekdaySymbol.isWeekend ? Color.primary : Color.secondary)
                            .frame(width: self.dayViewWidth(parentWidth: geometry.size.width),
                                   height: self.calendarDayHeight/2)
                            
                    }
                }
            }
        }
    }
    
    func dayViewWidth(parentWidth:CGFloat) -> CGFloat {
        return (parentWidth - 20) / 7
    }
}
