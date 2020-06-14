# SwiftClockUI

![Xcode Unit Test](https://github.com/renaudjenny/SwiftClockUI/workflows/Xcode%20Unit%20Test/badge.svg)

Clock UI for SwiftUI

This library has been tested
* ✅💻 macOS Catalina 10.15.3
* ✅📱 iOS 13.3

## Bind a date

```swift
struct ContentView: View {
    @State private var date = Date()

    var body: some View {
        ClockView().environment(\.clockDate, $date)
    }
}
```

Simply set `.environment(\.clockDate, $date)` `$date` has to be a binding.
If you want something constant (just for showing the time), you could pass `.constant(yourDate)`

* Arms move when date are set (take hour and minute in account)
* Move the Arms change the date (hour and minute depending on wich arm you've moved)

## Change Clock style

There is 4 different clock style:

Style | Picture
------------ | -------------
Classic | ![Clock View with Classic style](docs/assets/ClockViewClassic.png)
Art Nouveau | ![Clock View with Art Nouveau style](docs/assets/ClockViewArtNouveau.png)
Drawing | ![Clock View with Darwing style](docs/assets/ClockViewDrawing.png)
Steampunk | ![Clock View with Steampunk style](docs/assets/ClockViewSteampunk.png)

To set the style: `.environment(\.clockStyle, .steampunk)` for Steampunk style for instance.

```swift
struct ContentView: View {
    @State private var clockStyle: ClockStyle = .classic

    var body: some View {
        ClockView().environment(\.clockStyle, clockStyle)
    }
}
```

`\.clockStyle` is typed as `enum ClockStyle`  which is `Identifiable`, `CaseIterable`, and has a convenient method to get the description (in English): `public var description: String`

It's very useful when you want to iterate over this `enum` to let the user choose the clock style, for instance you can easily do something like this:

```swift
struct StylePicker: View {
    @Binding var clockStyle: ClockStyle

    var body: some View {
        Picker("Style", selection: clockStyle) {
            ForEach(ClockStyle.allCases) { style in
                Text(style.description).tag(style)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}
```

## Change elements color (TODO 🛠)

See #7

## App using this library

* [📲 Tell Time UK](https://apps.apple.com/gb/app/tell-time-uk/id1496541173): https://github.com/renaudjenny/telltime

## TODO

* 👆 Add a bigger zone for dragging arms, it's not easy with the mouse on macOS
  * Use the new `.hover` and `.hoverEffect` from Swift 5.2 and Xcode 11.4
* 👾 Add a smooth animation while resizing the window on macOS
