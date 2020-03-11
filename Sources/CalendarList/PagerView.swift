//
//  PagerView.swift
//  CalendarList
//
//  Created by Jorge Villalobos Beato on 3/11/20.
//  Copyright © 2020 Majid Jabrayilov + Jorge Villalobos Beato. All rights reserved.
//
//  https://swiftwithmajid.com/2019/12/25/building-pager-view-in-swiftui/
//

import SwiftUI

/// SwiftUI view that displays contained children in pages, like a  `UIPageViewController` in UIKit.
///
/// Parameters to initialize:
///   - pageCount: number of pages.
///   - currentIndex: binding fo current page.
///   - pageChanged: block to be called whenever a new page is displayed.
///   - content: `@ViewBuilder` block to generate all children pages.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
struct PagerView<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content
    
    @GestureState private var translation: CGFloat = 0
    
    var pageChanged: ((Int) -> ())? = nil
    
    /// Creates a new `PagerView` to display paginated, scrolling views.
    /// - Parameters:
    ///   - pageCount: number of pages.
    ///   - currentIndex: binding fo current page.
    ///   - pageChanged: block to be called whenever a new page is displayed.
    ///   - content: `@ViewBuilder` block to generate all children pages.
    init(pageCount: Int, currentIndex: Binding<Int>, pageChanged: ((Int) -> ())? = nil, @ViewBuilder content: () -> Content) {
        
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.pageChanged = pageChanged
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center , spacing: 0) {
                self.content.frame(width: geometry.size.width)
                //, alignment: .topLeading)
            }
        
            .frame(width: geometry.size.width, alignment: .leading)
            .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
            .offset(x: self.translation)
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.width
                }.onEnded { value in
                    let offset = value.translation.width / geometry.size.width
                    let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                    
                    let oldIndex = self.currentIndex
                    
                    self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                    
                    if oldIndex != self.currentIndex, let pageChanged = self.pageChanged {
                        pageChanged(self.currentIndex)
                    }
                
                }
            )
        }
    }
}
