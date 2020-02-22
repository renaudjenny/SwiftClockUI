# SwiftClockUI

Clock UI for SwiftUI

⚠️ It's very unstable right now. I'm currently highly working on it and changing the code. Don't use it now!

TODO: add some pictures

## Bind a date

```swift
struct ContentView: View {
    @Environment(\.calendar) private var calendar
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
