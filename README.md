# CalendarList

[![Badge](https://img.shields.io/badge/License-MIT-green.svg)](https://shields.io/)
[![Badge](https://img.shields.io/badge/Swift-5.0-blue.svg)](https://shields.io/)
[![Badge](https://img.shields.io/badge/Xcode-11-blue.svg)](https://shields.io/)
[![Badge](https://img.shields.io/badge/platforms-iOS%20aa%20|%20macOS%20bb%20-blue.svg)](https://shields.io/)

SwiftUI view to display paginated calendar months and list events per selected day.

- [Features](#features)
- [Usage](#usage)
- [Requirements](#requirements)
- [Installation](#installation)
- [Questions or feedback?](#questions-or-feedback)

## Features

- [x] Internationalized, localized reusable SwiftUI calendar view
- [x] Generic event data type
- [x] List representation of events for a given day
- [x] View generation for each event is handled by the parent view
- [x] Customizable styles for "today" and "selected" dates

## Usage

CalendarList takes two main arguments:

- Array of `CalendarEvent` elements. This type wraps the date for the event and the actual data you want to use. As long as the data comforms to the `Hashable` protocol, you can use any type you want.
- A`@ViewBuilder` block that will be used to generate the view that represents an event on a given day.

This is a very basic example using `String` as type for the data and a `Text` view to represent the event data:

```swift
struct ContentView: View {
    var events = [
        CalendarEvent(dateString: "03/21/2020", data: "Event 1"),
        CalendarEvent(dateString: "03/23/2020", data: "Event 2"),
        CalendarEvent(dateString: "03/26/2020", data: "Event 3"),
        CalendarEvent(dateString: "03/26/2020", data: "Event 4"),
    ]
    
    var body: some View {
        CalendarList(events: self.events) { event in
            Text("\(event.data)")
        }
    }
}
```

This results in the following:

<img src="Resources/Video1.gif" width="40%">


## Requirements

- iOS 13+ / macOS 10.15+
- Xcode 11+
- Swift 5+

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate CalendarList into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'CalendarList', '~> 1.0'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate CalendarList into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "tiusender/CalendarList" ~> 1.0
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. Just add the following dependency on your Xcode project:

```ogdl
https://github.com/tiusender/CalendarList.git
```

## Questions or feedback?

Feel free to [open an issue](https://github.com/tiusender/CalendarList/issues/new), or find me [@tiusender on Twitter](https://twitter.com/tiusender).
