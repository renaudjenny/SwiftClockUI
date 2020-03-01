# SwiftClockUI

Clock UI for SwiftUI

⚠️ It's very unstable right now. I'm currently highly working on it and changing the code. Don't use it now!

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

## TODO

* 📷 Add some demo pictures
* 📲 Add the link to the different apps who are using this library
* 👆 Add a bigger zone for dragging arms, it's not easy with the mouse on macOS
* 👾 Add a smooth animation while resizing the window on macOS
* ⚠️  Address TODO and FIXME
* 🧽 Add Linter rules
