Goal: be done by memorial day. Which is 56 days total.

[Glossary of Swift Terms](https://www.hackingwithswift.com/glossary)
[SwiftUI By Example](https://www.hackingwithswift.com/quick-start/swiftui)

# Day 31
20 April
https://www.hackingwithswift.com/100/swiftui/31

# Day 30
20 April
https://www.hackingwithswift.com/100/swiftui/30

> when the user presses return on the keyboard, and in SwiftUI we can do that by
> adding an onSubmit() modifier somewhere in our view hierarchy – it could be
> directly on the button, but it can be anywhere else in the view because it
> will be triggered when any text is submitted

Disable auto caps on a TextField with `.autocapitalization(.none)`.

> SF Symbols provides numbers in circles from 0 through 50, all named using the
> format “x.circle.fill” – so 1.circle.fill, 20.circle.fill.
> `Image(systemName: "\(word.count).circle")`

Animate an action (this is in a func. will cover animations later)
```swift
withAnimation {
    usedWords.insert(answer, at: 0)
}
```

> When we call fatalError() it will – unconditionally and always – cause our app
> to crash

SwiftUI gives us a dedicated view modifier for running a closure when a view is
shown:

```swift
.onAppear(perform: startGame)
```

# Day 29
19 April
https://www.hackingwithswift.com/100/swiftui/29

`List` is a workhorse. UITableView equvalent. `Form`, except form is for user
input. Can have `Section`s. Style with `.listStyle`

>  one thing List can do that Form can’t is to generate its rows entirely from
>  dynamic content without needing a ForEach.

```swift
List(0..<5) {
    Text("Dynamic row \($0)")
}
```

Fetching files from the app bundle

```swift
if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
  // we found the file in our bundle!
  if let fileContents = try? String(contentsOf: fileURL) {
      // we loaded the file into a string!
      // NOTE: do this in a do/catch block
  }
}
```

Separating a string into an array of components

```swift
let input = "a b c"
let letters = input.components(separatedBy: " ")
// output is ['a', 'b', 'c']
// can get a random element
letters.randomElement() // returns Optional String

// trim whitespace
let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
```

Spell check

```swift
let word = "swift"
let checker = UITextChecker() // this is an objective-c API

// convert a swift string into an objective-c range
let range = NSRange(location: 0, length: word.utf16.count)

// That sends back another Objective-C string range, telling us where the
// misspelling was found.
let misspelledRange = checker.rangeOfMisspelledWord(
  in: word,
  range: range,
  startingAt: 0,
  wrap: false,
  language: "en"
)
// obj-c doesn't have the concept of optionals, so need to check for nil
let allGood = misspelledRange.location == NSNotFound
```

# Day 28
18 April
https://www.hackingwithswift.com/100/swiftui/28

# Day 27
18 April
https://www.hackingwithswift.com/100/swiftui/27

# Day 26
18 April
https://www.hackingwithswift.com/100/swiftui/26

Steppers
can provide a limit on their range with `in: 2...4` param
can provide a step by which to change with each tap `step: 0.25`
use `.formatted()` on a Double to make it look nice

DatePicker and Date
use `.labelsHidden()` modifier to hide the DatePicker label but keep the text
description for screen readers.

note: `selection: $binding` seems to be how two way bindings take args
(TextField and DatePicker for eg) but sometimes it's `value: $binding`

use `displayedComponents: ` to determine which DatePicker UI to show.

use `in: ` to limit the date input range. To create a range of Dates:
```swift
let tomorrow = Date.now.addingTimeInterval(86400)

let range = Date.now...tomorrow
 ```

Swift has one-sided ranges too:
```swift
let range = Date.now...
```

Use `DateComponents` instead of `Date` to modify different parts of a Date:
```swift
var components = DateComponents()
components.hour = 8
components.minute = 0
let date = Calendar.current.date(from: components)
// date(from:) returns an Optional Date. Use nil coalescing:
let date = Calendar.current.date(from: components) ?? Date.now
```

To pull out specific components from a Date:
```
let components = Calendar.current.dateComponents([.hour, .minute], from:
someDate)
// each component is an Optional
let hour = components.hour ?? 0
let minute = components.minute ?? 0

```

Date takes a formatter, which is locale-specific:
```
Text(Date.now, format: .dateTime.day().month().year())
// or
Text(Date.now.formatted(date: .long, time: .shortened))
```

CreateML

`tabular regression`
> throw a load of spreadsheet-like data at Create ML and ask it to figure out
> the relationship between various values

`target`: which is the value we want the computer to learn to predict, and the
`features`: which are the values we want the computer to inspect in order to
predict the target

CreateML For Everyone: https://youtu.be/a905KIBw1hs

# Day 25
16 April
https://www.hackingwithswift.com/100/swiftui/25

Review
classes v structs
bindings
https://www.hackingwithswift.com/guide/ios-swiftui/2/2/key-points
https://www.hackingwithswift.com/guide/ios-swiftui/2/1/what-you-learned

Rock Paper Scissors game build

# Day 24
16 April
https://www.hackingwithswift.com/100/swiftui/24

challenges

# Day 23
16 April
https://www.hackingwithswift.com/100/swiftui/23

Don't try to change what is 'behind' a view eg the background. Change the view
itself with a modifier, using `.frame` and `.background`.

> Whenever we apply a modifier to a SwiftUI view, we actually create a new view
> with that change applied – we don’t just modify the existing view in place.

Order matters with modifiers. Set a frame first.

`TupleView` is what you get internally when multiple views are returned in a
group like a stack. The max views is 10 per group because ToupleView only has
support for 2-10 views inside.

> Swift silently applies a special attribute to the body property called
> @ViewBuilder. This has the effect of silently wrapping multiple views in one
> of those TupleView containers, so that even though it looks like we’re sending
> back multiple views they get combined into one TupleView.

Can use ternary operator to control modifier properties.

> You can often use regular if conditions to return different views based on
> some state, but this actually creates more work for SwiftUI

Environment vs regular modifiers:

> Many modifiers can be applied to containers, which allows us to apply the same
> modifier to many views at the same time.

Containers are vstack group etc

> This is called an environment modifier, and is different from a regular
> modifier that is applied to a view.

> there is no way of knowing ahead of time which modifiers are environment
> modifiers and which are regular modifiers other than reading the individual
> documentation for each modifier and hope it’s mentioned

Views can be set as properties on a struct to be re-used in `Body`, but not
really ideal
https://www.hackingwithswift.com/books/ios-swiftui/views-as-properties

It's very efficient to break up views to DRY code.

> To create a custom modifier, create a new struct that conforms to the
> ViewModifier protocol

```swift
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
    }
}
```

best to create these as extensions on View though

```swift
extension View {
  func titleStyle() -> some View {
    modifier(Title())
  }
}
```

> custom view modifiers can have their own stored properties, whereas extensions
> to View cannot.

# Day 22
15 April
https://www.hackingwithswift.com/100/swiftui/22

# Day 21
15 April
https://www.hackingwithswift.com/100/swiftui/21

# Day 20
13 April
https://www.hackingwithswift.com/100/swiftui/20

If you want `some View` to show multiple views, you have to wrap them first.
Otherwise doing something like this will give you two _screens_:
```swift
var body: some View {
  Text("one")
  Text("two")
}
```
To get around that, use groups like nav controllers or stacks.

> Vertical and horizontal stacks automatically fit their content, and prefer to
> align themselves to the center of the available space. If you want to change
> that you can use one or more Spacer views to push the contents of your stack
> to one side.

> ZStack draws its contents from top to bottom, back to front

To set a background on an entire view, set it in a ZStack and add Color.red or
w/e as the first view.

Colors take up all space available, but can add a frame on them.

Use `.ignoresSafeArea() ` to draw into the entire screen even around the notch

Use `foregroundStyle` and `foregroundColor` to allow a background through or
not.

> Important: Apple explicitly recommends against using too many prominent
> buttons, because when everything is prominent nothing is.

You can pass a custom label to a Button's trailing closure to customize it. This
is typically used when you want an image to be the background.

> when should an alert be shown and how? Views are a function of our program
> state, and alerts aren’t an exception to that. So, rather than saying “show
> the alert”, we instead create our alert and set the conditions under which it
> should be shown.

> any button inside an alert will automatically dismiss the alert

add trailing closure to alert to add additional message.

# Day 19
13 April
https://www.hackingwithswift.com/100/swiftui/19

Can do unit conversions with this:
https://developer.apple.com/documentation/foundation/dimension

# Day 18
12 April
https://www.hackingwithswift.com/100/swiftui/18

WeSplit review and challenges.

To store a TextField formatter:

```swift
var currencyFormat: FloatingPointFormatStyle<Double>.Currency {
    FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currencyCode ?? "USD")
}
```

# Day 17
12 April
https://www.hackingwithswift.com/100/swiftui/17

WeSplit app.

`TextField(blah, value: number, format: .currency())`

To determine focus and show/hide keyboard based on that, first add a
`@FocusState` property, then add a `.focused($isFocused)` modifier to the
TextField, then add a toolbar to the NavigationView with a done button to set
isFocused to false. This button has a `placement` of `.keyboard` so it only
shows up with the keyboard.

# Day 16
11 April
https://www.hackingwithswift.com/100/swiftui/16

> View protocol has one requirement: a computed property called Body that
> returns `some View`

> Modifiers (`.padding()` for instance) return the original View plus the extra
> modification you asked for.

option + command + P to restart the Preview

SwiftUI has a limit of 10 children views per parent view. Get around it with
Group. Groups don't change things visually.

Use `Section` to split the view visually.

`Safe Area` keeps views out of eg the menu bar. Use a `NavigationView` to keep
content from scrolling up there.

Navigation Titles are added to children of `NavigationView`

"Views are a function of their state"

Property Wrappers allow struct properties to eg be mutable even though they're
in a Struct. `@State` allows a property to be stored by SwiftUI somewhere that
it can be modified. Recommended to use `private` with these.

Two-way bindings: when a view needs to write back a value that it's also
reading. Done with `$` in front of the var name eg
`TextField("hi", text: $name)`

`ForEach` creates views in a loop. Another way to get around the 10 child view
limit.

# Day 15
10 April
https://www.hackingwithswift.com/100/swiftui/15

Swift review, before getting into SwiftUI
https://www.hackingwithswift.com/articles/242/learn-essential-swift-in-one-hour

# Day 14
10 April
https://www.hackingwithswift.com/100/swiftui/14

Optionals

Three ways to unwrap:
- `if let`
- `guard let`
- nil coalescing `??`

# Day 13
10 April
https://www.hackingwithswift.com/100/swiftui/13

Protocols and Extensions

>  if you’re returning a new value rather than changing it in place, you should
>  use word endings like ed or ing, like reversed(). reverse() would change in
>  place.

# Day 12
9 April
https://www.hackingwithswift.com/100/swiftui/12

Classes

# Day 11
9 April
https://www.hackingwithswift.com/100/swiftui/11

struct access control, static properties and methods

# Day 10
9 April
https://www.hackingwithswift.com/100/swiftui/10

Structs, computed properties, property observers, initializers

# Day 9
8 April
https://www.hackingwithswift.com/100/swiftui/9

Closures

# Day 8
7 April
https://www.hackingwithswift.com/100/swiftui/8

Error handling

# Day 7
7 April
https://www.hackingwithswift.com/100/swiftui/7

Functions

# Day 6
7 April
https://www.hackingwithswift.com/100/swiftui/6

Loops

# Day 5
7 April
https://www.hackingwithswift.com/100/swiftui/5

Conditionals

# Day 4
6 April
https://www.hackingwithswift.com/100/swiftui/4

# Day 3
6 April
https://www.hackingwithswift.com/100/swiftui/3

**Arrays**
```swift
// create explicitly with generic syntax
var scores = Array<Int>()

// create with array syntax
var albums = [String]()
var albums: [String] = ["Red"]

// or implicitly
var names = ["brian"]

// remove at an index
names.remove(at: 0)
names.removeAll()

names.reverse()
```

**Dictionaries**
```swift
// create with dictionary syntax
var heights = [String: Int]()
heights["Yao Ming"] = 229
// this returns an Optional Int
heights["Yao Ming"]
// to receive an Int
heights["Yao Ming", default: 0]
```

**Sets**

```swift
// implicit, from an array.
let people = Set(["brian", "sara", "price"])
// or
let people = Set<String>()
people.insert("brian")
```

**Enums**
```swift
enum Weekday {
  case monday, tuesday, wednesday, thursday, friday
}

var day = Weekday.monday
day = .tuesday // shorthand, swift knows day's type
```

# Day 2
5 April
https://www.hackingwithswift.com/100/swiftui/2

# Day 1
5 April
https://www.hackingwithswift.com/100/swiftui/1
