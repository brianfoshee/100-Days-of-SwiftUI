Goal: be done by memorial day. Which is 56 days total.

ok I missed the memorial day goal but had a much needed vacation.

- [Glossary of Swift Terms](https://www.hackingwithswift.com/glossary)
- [SwiftUI By Example](https://www.hackingwithswift.com/quick-start/swiftui)

Notes for each Day:

# Day 100
24 June
https://www.hackingwithswift.com/100/swiftui/100

Final Exam: passed with merit, 94%

![cert](certificate.jpg)

# Day 99
17 June
https://www.hackingwithswift.com/100/swiftui/99

Challenges

# Day 98
17 June
https://www.hackingwithswift.com/100/swiftui/98

Size Classes

SwiftUI gives us two environment values to monitor the current size class of our
app, which in practice means we can show one layout when space is restricted and
another when space is plentiful.

That will tell us whether we have a regular or compact size class. Very roughly:

- All iPhones in portrait have compact width and regular height.
- Most iPhones in landscape have compact width and compact height.
- Large iPhones (Plus-sized and Max devices) in landscape have regular width and
  compact height.
- All iPads in both orientations have regular width and regular height when your
app is running with the full screen.

```swift
@Environment(\.horizontalSizeClass) var sizeClass
```

you can limit the range of Dynamic Type sizes supported by a particular view.
any size up to and including .xxxLarge is fine, but nothing larger:
```swift
.dynamicTypeSize(...DynamicTypeSize.xxxLarge)
```

# Day 97
15 June
https://www.hackingwithswift.com/100/swiftui/97

To display two views side by side, this is done by placing two views into a
NavigationView, then using a NavigationLink in the primary view to control
what’s visible in the secondary view.

when we use `static let` for properties, Swift automatically makes them lazy –
they don’t get created until they are used.

When we use a NavigationView, by default SwiftUI expects us to provide both a
primary view and a secondary detail view that can be shown side by side, with
the primary view shown on the left and the secondary on the right.

On landscape iPhones that are big enough – iPhone 13 Pro Max, for example –
SwiftUI’s default behavior is to show the secondary view, and provide the
primary view as a slide over.

UIKit lets us control whether the primary view should be shown on iPad portrait,
this is not yet possible in SwiftUI. However, we can stop iPhones from using the
slide over approach if that’s what you want – try it first and see what you
think. If you want it gone, add this extension
```swift
extension View {
    // We need to use the @ViewBuilder attribute here because the two returned
    // view types are different.
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}
```

# Day 96
14 June
https://www.hackingwithswift.com/100/swiftui/96

Present a sheet depending on whether an optional has a value. When the sheet
disappears the optional is set back to nil.
```swift
@State private var selectedUser: User? = nil

Text("Hello, World!")
    .onTapGesture {
        selectedUser = User()
    }
    .sheet(item: $selectedUser) { user in
        Text(user.id)
    }
```

.alert does the same thing, but it still needs a bool Binding:
```swift
.alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
    Button(user.id) { }
}
```

Leaving off a Button on an alert is okay, it'll show a default buton:
```swift
.alert("Welcome", isPresented: $isShowingUser) { }
```

size classes, which is a thoroughly vague way of telling us how much space we
have for our views. we have only two size classes horizontally and vertically,
called “compact” and “regular”.

```swift
@Environment(\.horizontalSizeClass) var sizeClass

if sizeClass == .compact {
    VStack(content: UserView.init)
} else {
    HStack(content: UserView.init)
}
```

UserView just doesn’t care – its Group simply groups the text views together
without affecting their layout at all, so the layout arrangement UserView is
given depends entirely on how it’s used.

Search Views

```swift
@State private var searchText = ""

NavigationView {
    Text("Searching for \(searchText)")
        .searchable(text: $searchText, prompt: "Look for something")
        .navigationTitle("Searching")
}
```

# Day 95
14 June
https://www.hackingwithswift.com/100/swiftui/95

Milestone project.

# Day 94
13 June
https://www.hackingwithswift.com/100/swiftui/94

Challenges

# Day 93
13 June
https://www.hackingwithswift.com/100/swiftui/93

GeometryReader. This lets us read the size and position for a view at runtime,
and keep reading those values as they change over time.

Absolute View Positioning

SwiftUI gives us two ways of positioning views: absolute positions using
position(), and relative positions using offset()

If you want to absolute position:
```swift
Text("Hello, world!")
    .position(x: 100, y: 100)
```

when we use position() we get back a new view that takes up all available space,
so it can position its child (the text) at the correct location.

If you offset some text its original dimensions don’t actually change, even
though the resulting view is rendered in a different location.
```swift
Text("Hello, world")
    .offset(x: 100, y: 100)
    .background(.red)
```

Frames and Coordinates in GeometryReader

In its most basic usage, what GeometryReader does is let us read the size that
was proposed by the parent, then use that to manipulate our view.

we could use GeometryReader to make a text view have 90% of all available width
regardless of its content:
```swift
GeometryReader { geo in
     Text("Hello, World!")
         .frame(width: geo.size.width * 0.9)
         .background(.red)
}
```

That geo parameter that comes in is a GeometryProxy, and it contains the
proposed size, any safe area insets that have been applied, plus a method for
reading frame values that we’ll look at in a moment.

GeometryReader has an interesting side effect that might catch you out at first:
the view that gets returned has a flexible preferred size, which means it will
expand to take up more space as needed.

coordinate spaces:
the global space: measuring our view’s frame relative to the whole screen
the local space: measuring our view’s frame relative to its parent

We can also create custom coordinate spaces by attaching the coordinateSpace()
modifier to a view – any children of that can then read its frame relative to
that coordinate space.

See LayoutAndGeometry project for code that explains this:
- A global center X of 189 means that the center of the geometry reader is 189
  points from the left edge of the screen.
- A global center Y of 430 means the center of the text view is 430 points from
  the top edge of the screen. This isn’t dead in the center of the screen
  because there is more safe area at the top than the bottom.
- A custom center X of 189 means the center of the text view is 189 points from
  the left edge of whichever view owns the “Custom” coordinate space, which in
  our case is OuterView because we attach it in ContentView. This number matches
  the global position because OuterView runs edge to edge horizontally.
- A custom center Y of 383 means the center of the text view is 383 points from
  the top edge of OuterView. This value is smaller than the global center Y
  because OuterView doesn’t extend into the safe area.
- A local center X of 152 means the center of the text view is 152 points from
  the left edge of its direct container, which in this case is the
  GeometryReader.
- A local center Y of 350 means the center of the text view is 350 points from
  the top edge of its direct container, which again is the GeometryReader.

Which coordinate space you want to use depends on what question you want to
answer:

- Want to know where this view is on the screen? Use the global space.
- Want to know where this view is relative to its parent? Use the local space.
- What to know where this view is relative to some other view? Use a custom space.

frame(in:) method of a GeometryProxy, SwiftUI will calculate the view’s current
position in the coordinate space we ask for.

# Day 92
12 June
https://www.hackingwithswift.com/100/swiftui/92

Layout and Geometry

All SwiftUI layout happens in three simple steps, and understanding these steps
is the key to getting great layouts every time. The steps are:

- A parent view proposes a size for its child.
- Based on that information, the child then chooses its own size and the parent
  must respect that choice.
- The parent then positions the child in its coordinate space.

Behind the scenes, SwiftUI performs a fourth step: although it stores positions
and sizes as floating-point numbers, when it comes to rendering SwiftUI rounds
off any pixels to their nearest values so our graphics remain sharp.

how big is ContentView? the size of ContentView is exactly and always the size
of its body, no more and no less. This is called being layout neutral:
ContentView doesn’t have any size of its own, and instead happily adjusts to fit
whatever size is needed.

when you apply a modifier to a view we actually get back a new view type called
ModifiedContent, which stores both our original view and its modifier. This
means when we apply a modifier, the actual view that goes into the hierarchy is
the modified view, not the original one.

if your view hierarchy is wholly layout neutral, then it will automatically take
up all available space.

applying modifiers creates new views rather than just modifying existing views
in-place.

Alignment

The simplest alignment option is to use the alignment parameter of a frame()
modifier.
```swift
Text("Live long and prosper")
    .frame(width: 300, height: 300, alignment: .topLeading)
```

Next option is to use a Stack with alignment:
```swift
HStack(alignment: .bottom) {
```

If text views of differing size need to line up use
```swift
HStack(alignment: .lastTextBaseline) {
```

alignmentGuide() modifier for custom alignments inside a Stack
This takes two parameters: the guide we want to change, and a closure that
returns a new alignment. The closure is given a ViewDimensions object that
contains the width and height of its view, along with the ability to read its
various edges.
```swift
VStack(alignment: .leading) {
    Text("Hello, world!")
        .alignmentGuide(.leading) { d in d[.trailing] }
    Text("This is a longer line of text")
}
```

Custom Alignment Guide

SwiftUI gives us alignment guides for the various edges of our views. However,
none of these work well when you’re working with views that are split across
disparate views – if you have to make two views aligned the same when they are
in entirely different parts of your user interface. To fix this, SwiftUI lets us
create custom alignment guides.

This should be an extension on either VerticalAlignment or HorizontalAlignment,
and be a custom type that conforms to the AlignmentID protocol.

See code from today, in LayoutAndGeometry project.

# Day 91
28 May
https://www.hackingwithswift.com/100/swiftui/91

TODO figure this one out

If you drag a card to the right but not far enough to remove it, then release,
you see it turn red as it slides back to the center. Why does this happen and
how can you fix it? (Tip: think about the way we set offset back to 0
immediately, even though the card hasn’t animated yet. You might solve this with
a ternary within a ternary, but a custom modifier will be cleaner.)

# Day 90
28 May
https://www.hackingwithswift.com/100/swiftui/90

More control over Haptics

Creating an instance of one of the subclasses of UIFeedbackGenerator then
triggering it when you’re ready, but for more precise control over feedback you
should first call its prepare() method to give the Taptic Engine chance to warm
up.

Warming up the Taptic Engine helps reduce the latency between us playing the
effect and it actually happening, but it also has a battery impact so the system
will only stay ready for a second or two after you call prepare().

it’s OK to call prepare() then never triggering the effect – the system will
keep the Taptic Engine ready for a few seconds then just power it down again.
If you repeatedly call prepare() and never trigger it the system might start
ignoring your prepare() calls until at least one effect has happened.

it’s perfectly allowable to call prepare() many times before triggering it once
– prepare() doesn’t pause your app while the Taptic Engine warms up, and also
doesn’t have any real performance cost when the system is already prepared.

while you’re testing out in small doses these haptics probably feel great –
you’re making your phone buzz, and it can be really delightful. However, if
you’re a serious user of this app then our haptics might hit two problems:

- The user might find them annoying, because they’ll happen once every two or
  three seconds depending on how fast they are.
- Worse, the user might become desensitized to them – they lose all usefulness
  either as a notification or as a little spark of delight.

# Day 89
27 May
https://www.hackingwithswift.com/100/swiftui/89

SwiftUI lets us disable interactivity for a view by setting allowsHitTesting()
to false.

# Day 88
26 May
https://www.hackingwithswift.com/100/swiftui/88

Building the flashcard app

App is landscape-only, removed the portrait entries in Target -> Info

A width of 450 is no accident: the smallest iPhones have a landscape width of
480 points, so this means our card will be fully visible on all devices.

Create an array of repeating value:
```swift
var cards = [Card](repeating: Card.example, count: 10)
```

Important stuff about order of modifiers when dragging / rotating / translating
etc
https://www.hackingwithswift.com/books/ios-swiftui/moving-views-with-draggesture-and-offset

# Day 87
24 May
https://www.hackingwithswift.com/100/swiftui/87

Combine

Timer class, which is designed to run a function after a certain number of
seconds, but it can also run code repeatedly. Combine adds an extension to this
so that timers can become publishers, which are things that announce when their
value changes. `@Published` and `ObservableObject` use Combine

The following sets up a timer:
- It asks the timer to fire every 1 second.
- It says the timer should run on the main thread.
- It says the timer should run on the common run loop, which is the one you’ll
  want to use most of the time. (Run loops let iOS handle running code while the
  user is actively doing something, such as scrolling in a list.)
- It connects the timer immediately, which means it will start counting time.
- It assigns the whole thing to the timer constant so that it stays alive.

```swift
let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
```

onReceive() modifier. This accepts a publisher as its first parameter and a
function to run as its second, and it will make sure that function is called
whenever the publisher sends its change notification.

```swift
Text("Hello, World!")
    .onReceive(timer) { time in
        print("The time is now \(time)")
    }
```

Canceling the timer: timer property we made is an autoconnected publisher, so we
need to go to its upstream publisher to find the timer itself

```swift
timer.upstream.connect().cancel()
```

Tolerance allows iOS to perform important energy optimization, because it can
fire the timer at any point between its scheduled fire time and its scheduled
fire time plus the tolerance you specify

```swift
let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
```

the Timer class is still “best effort” – the system makes no guarantee it will
execute precisely.

Detecting an app entering Foreground / Background

- Adding a new property to watch an environment value called scenePhase.
- Using onChange() to watch for the scene phase changing.
- Responding to the new scene phase somehow.

```swift
@Environment(\.scenePhase) var scenePhase

Text("Hello, world!")
    .padding()
    .onChange(of: scenePhase) { newPhase in
        if newPhase == .active {
            print("Active")
        } else if newPhase == .inactive {
            print("Inactive")
        } else if newPhase == .background {
            print("Background")
        }
    }
```

- Active scenes are running right now, which on iOS means they are visible to
  the user. On macOS an app’s window might be wholly hidden by another app’s
  window, but that’s okay – it’s still considered to be active.
- Inactive scenes are running and might be visible to the user, but the user
  isn’t able to access them. For example, if you’re swiping down to partially
  reveal the control center then the app underneath is considered inactive.
- Background scenes are not visible to the user, which on iOS means they might
  be terminated at some point in the future.

Specific Accessibility Settings

SwiftUI gives us a number of environment properties that describe the user’s
custom accessibility settings

For color blineness:
```swift
@Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
```

or

For reduced motion:
```swift
@Environment(\.accessibilityReduceMotion) var reduceMotion
@State private var scale = 1.0

Text("Hello, World!")
    .scaleEffect(scale)
    .onTapGesture {
        if reduceMotion {
            scale *= 1.5
        } else {
            withAnimation {
                scale *= 1.5
            }
        }
    }
```

cleaning that up:
```swift
func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

.onTapGesture {
    withOptionalAnimation {
        scale *= 1.5
    }
}
```

Reduce Transparency

```swift
@Environment(\.accessibilityReduceTransparency) var reduceTransparency

Text()
    .background(reduceTransparency ? .black : .black.opacity(0.5))
```

# Day 86
23 May
https://www.hackingwithswift.com/100/swiftui/86

Gestures

onTapGesture can take a count param for handling double tap etc
```swift
.onTapGesture(count: 2) {
        print("Double tapped!")
}
```

Long Press

```swift
.onLongPressGesture {
        print("Long pressed!")
}

.onLongPressGesture(minimumDuration: 2) {
    print("Long pressed!")
}
```

You can even add a second closure that triggers whenever the state of the
gesture has changed. This will be given a single Boolean parameter as input, and
it will work like this:

- As soon as you press down the change closure will be called with its parameter
  set to true.
- If you release before the gesture has been recognized (so, if you release
  after 1 second when using a 2-second recognizer), the change closure will be
  called with its parameter set to false.
- If you hold down for the full length of the recognizer, then the change
  closure will be called with its parameter set to false (because the gesture is
  no longer in flight), and your completion closure will be called too.

```swift
.onLongPressGesture(minimumDuration: 1) {
    print("Long pressed!")
} onPressingChanged: { inProgress in
    print("In progress: \(inProgress)!")
}
```

For more advanced gestures you should use the gesture() modifier with one of the
gesture structs: DragGesture, LongPressGesture, MagnificationGesture,
RotationGesture, and TapGesture. These all have special modifiers, usually
onEnded() and often onChanged() too, and you can use them to take action when
the gestures are in-flight (for onChanged()) or completed (for onEnded()).

attach a magnification gesture to a view so that pinching in and out scales the
view up and down:

```swift
@State private var currentAmount = 0.0
@State private var finalAmount = 1.0

Text("Gesturing")
    .scaleEffect(finalAmount + currentAmount)
    .gesture(
        MagnificationGesture()
            .onChanged { amount in
                currentAmount = amount - 1
            }
            .onEnded { amount in
                finalAmount += currentAmount
                currentAmount = 0
            }
    )
```

Do the same but with rotation:
```swift
@State private var currentAmount = Angle.zero
@State private var finalAmount = Angle.zero

Text("Hello, World!")
    .rotationEffect(currentAmount + finalAmount)
    .gesture(
        RotationGesture()
            .onChanged { angle in
                currentAmount = angle
            }
            .onEnded { angle in
                finalAmount += currentAmount
                currentAmount = .zero
            }
    )
```

Gestures can clash. In this scenario the child gesture has priority:

```swift
VStack {
    Text("Hello, World!")
        .onTapGesture {
            print("Text tapped")
        }
}
.onTapGesture {
    print("VStack tapped")
}
```

This can be overridden with:
```swift
VStack {
    Text("Hello, World!")
        .onTapGesture {
            print("Text tapped")
        }
}
.highPriorityGesture(
    TapGesture()
        .onEnded { _ in
            print("VStack tapped")
        }
)
```

Alternatively, you can use the simultaneousGesture() modifier to tell SwiftUI
you want both the parent and child gestures to trigger at the same time:

```swift
VStack {
    Text("Hello, World!")
        .onTapGesture {
            print("Text tapped")
        }
}
.simultaneousGesture(
    TapGesture()
        .onEnded { _ in
            print("VStack tapped")
        }
)
```

`gesture sequences`, where one gesture will only become active if another
gesture has first succeeded.

This allows you to drag a circle around, but only if you long press on it first:

```swift
// how far the circle has been dragged
@State private var offset = CGSize.zero

// whether it's being dragged
@State private var isDragging = false

let dragGesture = DragGesture()
    .onChanged { value in offset = value.translation }
    .onEnded { _ in
        withAnimation {
            offset = .zero
            isDragging = false
        }
    }

let longPressGesture = LongPressGesture()
    .onEnded { value in
        withAnimation {
            isDragging = true
        }
    }

let combined = longPressGesture.sequenced(before: dragGesture)

Circle()
    .fill(.red)
    .frame(width: 64, height: 64)
    .scaleEffect(isDragging ? 1.5: 1)
    .offset(offset)
    .gesture(combined)
```

Good Vibrations

Basics: options are .success .error .warning

```swift
func simpleSuccess() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
}

Text("Hello, World!")
    .onTapGesture(perform: simpleSuccess)
```

CoreHaptics for more advanced uses

```swift
import CoreHaptics

// create an instance of CHHapticEngine, which is responsible for creating
// vibrations
@State private var engine: CHHapticEngine?

// start the haptic engine.
func prepareHaptics() {
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

    do {
        engine = try CHHapticEngine()
        try engine?.start()
    } catch {
        print("There was an error creating the engine: \(error.localizedDescription)")
    }
}

// configure a tap
func complexSuccess() {
    // make sure that the device supports haptics
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
    var events = [CHHapticEvent]()

    // create one intense, sharp tap
    let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
    let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
    let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
    events.append(event)

    // convert those events into a pattern and play it immediately
    do {
        let pattern = try CHHapticPattern(events: events, parameters: [])
        let player = try engine?.makePlayer(with: pattern)
        try player?.start(atTime: 0)
    } catch {
        print("Failed to play pattern: \(error.localizedDescription).")
    }
}

// set it all up in a view
Text("Hello, World!")
    .onAppear(perform: prepareHaptics)
    .onTapGesture(perform: complexSuccess)
```

Experiment further with adding more events:

```swift
for i in stride(from: 0, to: 1, by: 0.1) {
    let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
    let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
    let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
    events.append(event)
}

for i in stride(from: 0, to: 1, by: 0.1) {
    let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
    let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
    let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
    events.append(event)
}
```

Hit Testing

SwiftUI has an advanced hit testing algorithm that uses both the frame of a view
and often also its contents. For example, if you add a tap gesture to a text
view then all parts of the text view are tappable – you can’t tap through the
text if you happen to press exactly where a space is. On the other hand, if you
attach the same gesture to a circle then SwiftUI will ignore the transparent
parts of the circle.

`.allowsHitTesting(false)` will pass through taps to views behind it.

`contentShape()` modifier, which lets us specify the tappable shape for
something. eg make a circle a rectangle `.contentShape(Rectangle())`

For instance if a Stack has a Spacer and the Spacer is tapped, the gesture
recognizer will not fire unless you give it a shape

```swift
VStack {
    Text("Hello")
    // will not accept taps
    Spacer().frame(height: 100)
    Text("World")
}
// uncomment this to allow the Spacer to accept taps
// .contentShape(Rectangle())
.onTapGesture {
    print("VStack tapped!")
}
```

# Day 85
22 May
https://www.hackingwithswift.com/100/swiftui/85

Adding Multiple Items To A Toolbar

```swift
.toolbar {
    ToolbarItemGroup(placement: .navigationBarLeading) {
      // button
    }

    ToolbarItemGroup(placement: .navigationBarTrailing) {
      // button
    }
}
```

# Day 84
22 May
https://www.hackingwithswift.com/100/swiftui/84

Modifying state error:

> Modifying state during view update, this will cause undefined behavior.

we’re telling Swift it can load our image by calling the generateQRCode()
method, so when SwiftUI calls the body property it will run generateQRCode() as
requested. However, while it’s running that method, we then change our new
@State property, even though SwiftUI hasn’t actually finished updating the body
property yet. (see
[MeView.swift](https://www.hackingwithswift.com/books/ios-swiftui/adding-a-context-menu-to-an-image))

On Checking Notification Permissions

we also need to be careful subsequent times because the user can retroactively
change their mind and disable notifications.

One option is to call requestAuthorization() every time we want to post a
notification, and honestly that works great: the first time it will show an
alert, and all other times it will immediately return success or failure based
on the previous response.

A more complete alternative: we can request the current authorization settings,
and use that to determine whether we should schedule a notification or request
permission. the settings object handed back to us includes properties such as
alertSetting to check whether we can show an alert or not – the user might have
restricted this so all we can do is display a numbered badge on our icon.

```swift
let addRequest = {
// setup the notification center request in here. see earlier days for info, or
code.
}

center.getNotificationSettings { settings in
    if settings.authorizationStatus == .authorized {
        addRequest()
    } else {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                addRequest()
            } else {
                print("could not authorize for notifications")
            }
        }
    }
}
```

# Day 83
21 May
https://www.hackingwithswift.com/100/swiftui/83

`textContentType()` modifier tells iOS what kind of information we’re asking the
user for. This should allow iOS to provide autocomplete data on behalf of the
user.

If an array is marked with @Published, and we add or remove items from that
array a change notification will be sent out. However, if we quietly change an
item inside the array then SwiftUI won’t detect that change, and no views will
be refreshed.

Add this to the Prospects class
```swift
func toggle(_ prospect: Prospect) {
    // call send before doing anything else
    objectWillChange.send()
    prospect.isContacted.toggle()
}
```

`fileprivate(set)`, which means “this property can be read from anywhere, but only
written from the current file”

# Day 82
21 May
https://www.hackingwithswift.com/100/swiftui/82

Using environment objects:

1. Create a class for an individual entity. Class so one copy is shared.
```swift
class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var isContacted = false
}
```

2. Create an ObservableObject class that can store multiple entities as a
   Published property
```swift
@MainActor class Prospects: ObservableObject {
    @Published var people: [Prospect]

    init() {
        self.people = []
    }
}
```

3. Setup a StateObject in root view, add to .environmentObject, then confugure
   child views with EnvironmentObject to access.
```swift
// In the root view add this property
@StateObject var prospects = Prospects()

// add this to the root view, something like a TabView
.environmentObject(prospects)

// add this to all child views that need access
@EnvironmentObject var prospects: Prospects
```

Filter method of an array

This runs every element in a sequence through a test you provide as a closure,
and any elements that return true from the test are sent back as part of a new
array.

# Day 81
21 May
https://www.hackingwithswift.com/100/swiftui/81

Context Menus

SwiftUI lets us attach context menus to objects to provide this extra
functionality, all done using the contextMenu() modifier.

You can pass this a selection of buttons and they’ll be shown in order.

```swift
Text("Change Color")
       .padding()
       .contextMenu {
           Button("Red") {
               backgroundColor = .red
           }

           Button("Green") {
               backgroundColor = .green
           }

           Button("Blue") {
               backgroundColor = .blue
           }
       }
```

Each item in a context menu can have text and an image attached to it using a
Label view.

```swift
Button {
    backgroundColor = .red
} label: {
    Label("Red", systemImage: "checkmark.circle.fill")
}
```

tips for when working with context menus:

- If you’re going to use them, use them in lots of places – it can be
  frustrating to press and hold on something only to find nothing happens.
- Keep your list of options as short as you can – aim for three or less.
- Don’t repeat options the user can already see elsewhere in your UI.

Swipe Actions

`swipeActions(`) modifier, which lets us register one or more buttons on one or
both sides of a List row. By default buttons will be placed on the right edge of
the row, and won’t have any color.

```swift
List {
    Text("Taylor Swift")
        .swipeActions {
            Button {
                print("Hi")
            } label: {
                Label("Send message", systemImage: "message")
            }
        }
}
```

You can customize the edge where your buttons are placed by providing an edge
parameter to your swipeActions() modifier, and you can customize the color of
your buttons either by adding a tint() modifier to them with a color of your
choosing, or by attaching a button role.

```swift
List {
    Text("Taylor Swift")
        .swipeActions {
            Button(role: .destructive) {
                print("Hi")
            } label: {
                Label("Delete", systemImage: "minus.circle")
            }
        }
        .swipeActions(edge: .leading) {
            Button {
                print("Hi")
            } label: {
                Label("Pin", systemImage: "pin")
            }
            .tint(.orange)
        }
}
```

Local Notifications

UserNotifications lets us create notifications to the user that can be shown on
the lock screen. We have two types of notifications to work with, and they
differ depending on where they were created: local notifications are ones we
schedule locally, and remote notifications (commonly called push notifications)
are sent from a server somewhere. You have to request permissions to send them.

```swift
import UserNotifications

// button stuff
// Request Permissions:
UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
    if success {
        print("All set!")
    } else if let error = error {
        print(error.localizedDescription)
    }
}
```

Apple breaks them down into three parts to give it maximum flexibility:

- The content is what should be shown, and can be a title, subtitle, sound,
  image, and so on.
- The trigger determines when the notification should be shown, and can be a
  number of seconds from now, a date and time in the future, or a location.
- The request combines the content and trigger, but also adds a unique
  identifier so you can edit or remove specific alerts later on. If you don’t
  want to edit or remove stuff, use UUID().uuidString to get a random
  identifier.

The easiest trigger type to use is UNTimeIntervalNotificationTrigger, which lets
us request a notification to be shown in a certain number of seconds from now:

```swift
let content = UNMutableNotificationContent()
content.title = "Feed the dog"
content.subtitle = "It looks hungry"
content.sound = UNNotificationSound.default

// schedule for 5s in the future
let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

// choose a random identifier
let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

// add the notifcation request
UNUserNotificationCenter.current().add(request)
```

Swift Package Manager

go to the File menu and choose Add Packages. Enter a URL or choose from the
list. Select the Dependency Rule then add. The package will show up in the
Project Navigator under `Package Dependencies` and in the Project -> Info page.

# Day 80
20 May
https://www.hackingwithswift.com/100/swiftui/80

`objectWillChange`

Every class that conforms to ObservableObject automatically gains a property
called objectWillChange. This is a publisher, which means it does the same job
as the @Published property wrapper: it notifies any views that are observing
that object that something important has changed.

we have the opportunity to add extra functionality inside that willSet observer.
Perhaps you want to log something, perhaps you want to call another method, or
perhaps you want to clamp the integer inside value so it never goes outside of a
range – it’s all under our control now.

```swift
@MainActor class DelayedUpdater: ObservableObject {
    // Instead of using @Published, you can use objectWillChange
    // @Published var value = 0
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
}

// use with @StateObject as per usual
@StateObject var updater = DelayedUpdater()
```

Run a job later:
```swift
DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
```

`Result` type

allows us to encapsulate either a successful value or some kind of error type,
all in a single piece of data.

Instead of using do/catch like this:
```swift
func fetchReadings() async {
  do {
    let url = URL(string: "https://hws.dev/readings.json")!
      let (data, _) = try await URLSession.shared.data(from: url)
      let readings = try JSONDecoder().decode([Double].self, from: data)
      output = "Found \(readings.count) readings"
  } catch {
    print("download error")
  }
}
```

Wrap the async work in a Task, and then access its `result` to determine whether
it succeeded or failed:
```swift
func fetchReadings() async {
  // give Task a name so we can cancel etc
  let fetchTask = Task { () -> String in
    let url = URL(string: "https://hws.dev/readings.json")!
      let (data, _) = try await URLSession.shared.data(from: url)
      let readings = try JSONDecoder().decode([Double].self, from: data)
      return "Found \(readings.count) readings"
  }

  // get the Task's Result
  let result = await fetchTask.result

  // can either get the result status in a do block:
  do {
    output = try result.get()
  } catch {
    output = "Error: \(error.localizedDescription)"
  }

  // or a switch statement:
  switch result {
    case .success(let str):
      output = str
    case .failure(let error):
        output = "Error: \(error.localizedDescription)"
  }
}
```

the advantage of Result is that it lets us store the whole success or failure of
some work in a single value, pass that around wherever we need, and read the
error only when we’re ready.

Controlling Image Interpolation

```swift
Image("example")
    .interpolation(.none)
    .resizable()
    .scaledToFit()
    .frame(maxHeight: .infinity)
    .background(.black)
    .ignoresSafeArea()
```

If you have an Image that is being shown scaled up (eg the image is smaller than
the frame it's in) you can turn off interpolation with `.interpolation(.none)`
so pixel blending doesn't happen. The resulting image is sharper with jagged
edges intead of being blurry with jagged edges.

# Day 79
20 May
https://www.hackingwithswift.com/100/swiftui/79

HotProspects app

`@State` is used to work with state that is local to a single view, and how
`@ObservedObject` lets us pass one object from view to view so we can share it.
Well, `@EnvironmentObject` takes that one step further: we can place an object
into the environment so that any child view can automatically have access to it.

View chain: `A -> B -> B -> D -> E ->`

With @EnvironmentObject view A can put the object into the environment, view E
can read the object out from the environment, and views B, C, and D don’t have
to know anything happened.

environment objects use the same ObservableObject protocol you’ve already
learned, and SwiftUI will automatically make sure all views that share the same
environment object get updated when it changes.

If you try to load a variable with `@EnvironmentObject` and it does not exist,
your code will crash.

```swift
struct DisplayView: View {
    @EnvironmentObject var user: User

    var body: some View {
        Text(user.name)
    }
}

struct ContentView: View {
    @StateObject private var user = User()

    var body: some View {
        VStack {
            DisplayView().environmentObject(user)
        }
    }
}
```

Environment Objects work like dictionaries: The environment effectively lets us
use data types themselves for the key, and instances of the type as the value.
This is a bit mind bending at first, but imagine it like this: the keys are
things like Int, String, and Bool, with the values being things like 5, “Hello”,
and true, which means we can say “give me the Int” and we’d get back 5.

`TabView`

Attach `.tag` modifiers to each tab to allow programmic changing of tabs.

```swift
struct ContentView: View {
    @State private var selectedTab = "One"

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .onTapGesture {
                    selectedTab = "Two"
                }
                .tabItem {
                    Label("One", systemImage: "star")
                }
                .tag("One")

            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
        }
    }
}
```

# Day 78
20 May
https://www.hackingwithswift.com/100/swiftui/78

Adding a map to the Face Remember app.

Fetch a user's location:

```swift
import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
```

Use it like:
```swift
struct ContentView: View {
    let locationFetcher = LocationFetcher()

    var body: some View {
        VStack {
            Button("Start Tracking Location") {
                self.locationFetcher.start()
            }

            Button("Read Location") {
                if let location = self.locationFetcher.lastKnownLocation {
                    print("Your location is \(location)")
                } else {
                    print("Your location is unknown")
                }
            }
        }
    }
}
```

# Day 77
20 May
https://www.hackingwithswift.com/100/swiftui/77

Face Remember app.

# Day 76
16 May
https://www.hackingwithswift.com/100/swiftui/76

challenges.

# Day 75
16 May
https://www.hackingwithswift.com/100/swiftui/75

update old projects for accessibility

# Day 74
15 May
https://www.hackingwithswift.com/100/swiftui/74

We can control what VoiceOver reads for a given view by attaching two modifiers:
.accessibilityLabel() and .accessibilityHint(). They both take text containing
anything we want, but they serve different purposes:

- The label is read immediately, and should be a short piece of text that gets
  right to the point. If this view deletes an item from the user’s data, it
  might say “Delete”.
- The hint is read after a short delay, and should provide more details on what
  the view is there for. It might say “Deletes an email from your inbox”, for
  example.

```swift
Image()
  .onTapGesture { }
  .accessibilityLabel(labels[selectedPicture])
  .accessibilityAddTraits(.isButton)
  .accessibilityRemoveTraits(.isImage)
```

it’s important we ensure our UI removes as much clutter as possible there are
several ways we can control what VoiceOver reads out. There are three in
particular I want to focus on:

- Marking images as being unimportant for VoiceOver.
- Hiding views from the accessibility system.
- Grouping several views as one.

we can tell SwiftUI that a particular image is just there to make the UI look
better by using `Image(decorative:)`. tells SwiftUI it should be ignored by
VoiceOver. `.accessibilityHidden()` modifier, which makes any view completely
invisible to the accessibility system:

VoiceOver sees this as two unrelated text views, and so it will either read
“Your score is” or “1000” depending on what the user has selected. Both of those
are unhelpful, which is where the .accessibilityElement(children:) modifier
comes in: we can apply it to a parent view, and ask it to combine children into
a single accessibility element:
```swift
VStack {
    Text("Your score is")
    Text("1000")
        .font(.title)
}
.accessibilityElement(children: .combine)
```

A better solution:
```swift
VStack {
    Text("Your score is")
    Text("1000")
        .font(.title)
}
.accessibilityElement(children: .ignore)
.accessibilityLabel("Your score is 1000")
```

.ignore is the default parameter for children, so you can get the same results
as .accessibilityElement(children: .ignore) just by saying
.accessibilityElement().

We can specify custom swipe actions using accessibilityAdjustableAction()

```swift
VStack {
    Text("Value: \(value)")

    Button("Increment") {
        value += 1
    }

    Button("Decrement") {
        value -= 1
    }
}
.accessibilityElement()
.accessibilityLabel("Value")
.accessibilityValue(String(value))
.accessibilityAdjustableAction { direction in
    switch direction {
    case .increment:
        value += 1
    case .decrement:
        value -= 1
    default:
        print("Not handled.")
    }
}
```

# Day 73
14 May
https://www.hackingwithswift.com/100/swiftui/73

Review and challenges.

# Day 72
14 May
https://www.hackingwithswift.com/100/swiftui/72

MVVM: Model View View-Model

a way of getting some of our program state and logic out of our view structs. We
are, in effect, separating logic from layout.

Creating `ContentView-ViewModel.swift` file. We’re going to use this to create a
new class that manages our data, and manipulates it on behalf of the ContentView
struct so that our view doesn’t really care how the underlying data system
works.

The main actor is responsible for running all user interface updates, and adding
that attribute to the class means we want all its code – any time it runs
anything, unless we specifically ask otherwise – to run on that main actor.

```swift
extension ContentView {
    // this ViewModel is only for ContentView
    @MainActor class ViewModel: ObservableObject {

    }
}
```

behind the scenes whenever we use @StateObject or @ObservedObject Swift was
silently inferring the @MainActor attribute for us – it knows that both mean a
SwiftUI view is relying on an external object to trigger its UI updates, and so
it will make sure all the work automatically happens on the main actor.

However, that doesn’t provide 100% safety. Yes, Swift will infer this when used
from a SwiftUI view, but what if you access your class from somewhere else –
from another class, for example? Then the code could run anywhere, which isn’t
safe. So, by adding the @MainActor attribute here we’re taking a “belt and
braces” approach: we’re telling Swift every part of this class should run on the
main actor, so it’s safe to update the UI, no matter where it’s used.

Important Caveat: if we specifcally tell the app to call this code from
elsewhere it will not run on the main actor, for instance if we ask to unlock
with FaceID and its callback calls code here it will not run on the main actor.

One option to fix is to create a background task, then run something on the
MainActor:
```swift
Task {
    await MainActor.run {
        self.isUnlocked = true
    }
}
```

A better option is to tell the Task to run on the MainActor directly:
```swift
Task { @MainActor in
    self.isUnlocked = true
}
```

there will be a compiler warning about the main actor not appearing in a default
value. [Ignore, see this
article](https://www.hackingwithswift.com/forums/swiftui/expression-requiring-global-actor-mainactor-cannot-appear-in-default-value-expression-of-property-vm-this-is-an-error-in-swift-6/13695)

having all this functionality in a separate class makes it much easier to write
tests for your code. Views work best when they handle presentation of data,
meaning that manipulation of data is a great candidate for code to move into a
view model.

Encrypting saved data. Note: this will not enforce faceid/touchid upon reading!
It just encrypts at rest. Add the faceid stuff to unlock the app if it needs
protecting.

```swift
let data = try JSONEncoder().encode(locations)
try data.write(to: savePath, options: [.atomic, .completeFileProtection])
```

# Day 71
14 May
https://www.hackingwithswift.com/100/swiftui/71

we can use + to add text views together. This lets us create larger text views
that mix and match different kinds of formatting.
```swift
Text(page.title)
       .font(.headline)
   + Text(": ") +
   Text("Page description here")
       .italic()
```

# Day 70
13 May
https://www.hackingwithswift.com/100/swiftui/70

BucketList app

Can determine whether to show a sheet based on an optional(!):

```swift
@State private var selectedPlace: Location?

// in view body
.sheet(item: $selectedPlace) { place in
  // sheet appears when selectedPlace is not nil
  // place is unwrapped inside here
  // sickk
}
```

When you have a View (sheet view in this case) that needs initial values set for
@State properties, create an initializer to set the State struct's
`initialValue` property:
```swift
@State private var name: String
@State private var description: String

init(location: Location) {
    self.location = location

    _name = State(initialValue: location.name)
    _description = State(initialValue: location.description)
}
```

To use a callback function in a view when you don't want to pass a Binding
object, pass a closure with @escaping
```swift
var onSave: (Location) -> Void

init(location: Location, onsave: @escaping (Location) -> Void) {
// .. etc
```

@escaping means the function is being stashed away for user later on, rather
than being called immediately.

fixedSize() lets us bypass MapAnnotation's clipping so the text automatically
grows into as much space as needed.

# Day 69
13 May
https://www.hackingwithswift.com/100/swiftui/69

Maps

```swift
import MapKit

@State private var mapRegion = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
    span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
)

Map(coordinateRegion: $mapRegion)
```

Annotations

1. defining a new data type that contains your location
  - Whatever new data type you create to store locations, it must conform to the
    Identifiable protocol so that SwiftUI can identify each map marker uniquely.
2. creating an array of those containing all your locations
3. adding them as annotations in the map

MapMarker is the most basic annotation, just a red dot:
```swift
Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
    MapMarker(coordinate: location.coordinate)
}
```

MapAnnotation allows you to customize the view:
```swift
Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
    MapAnnotation(coordinate: location.coordinate) {
        Circle()
            .stroke(.red, lineWidth: 3)
            .frame(width: 44, height: 44)
    }
}

// can accept tap gestures:
MapAnnotation(coordinate: location.coordinate) {
    Circle()
        .stroke(.red, lineWidth: 3)
        .frame(width: 44, height: 44)
        .onTapGesture {
            print("Tapped on \(location.name)")
        }
}

// can be NavigationLinks
MapAnnotation(coordinate: location.coordinate) {
    NavigationLink {
        Text(location.name)
    } label: {
        Circle()
            .stroke(.red, lineWidth: 3)
            .frame(width: 44, height: 44)
    }
}
```

Securing with FaceID or TouchID

For some reason we pass the Touch ID request reason in code, and the Face ID
request reason in project options.

Add to target's info `Privacy - Face ID Usage Description` with message about
why you need.

Then `import LocalAuthentication`.

1. Create instance of LAContext, which allows us to query biometric status and
   perform the authentication check.
2. Ask that context whether it’s capable of performing biometric authentication.
   this is important because iPod touch has neither Touch ID nor Face ID.
3. If biometrics are possible, then we kick off the actual request for
   authentication, passing in a closure to run when authentication completes.
4. When the user has either been authenticated or not, our completion closure
   will be called and tell us whether it worked or not, and if not what the
   error was.

```swift
func authenticate() {
    let context = LAContext()
    var error: NSError?

    // check whether biometric authentication is possible
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
        // it's possible, so go ahead and use it
        let reason = "We need to unlock your data."

        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
            // authentication has now completed
            if success {
                // authenticated successfully
            } else {
                // there was a problem
            }
        }
    } else {
        // no biometrics
    }
}
```

To get this to work in the simulator:  go to the Features menu and choose Face
ID > Enrolled, then launch the app again. This time you should see the Face ID
prompt appear, and you can trigger successful or failed authentication by going
back to the Features menu and choosing Face ID > Matching Face or Non-matching
Face.

# Day 68
13 May
https://www.hackingwithswift.com/100/swiftui/68

Comparable Protocol

How to sort arrays of custom structs?

- Add the Comparable conformance to the struct definition
- Add a method called `<` that takes two users and returns true if the first should
be sorted before the second. `Operator Overloading`
- This method must be static
- Adding this method also gives us the `<` automatically

```swift
struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String

    static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}
```

Reading the app's Documents directory:

```swift
func getDocumentsDirectory() -> URL {
    // find all possible documents directories for this user
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    // just send back the first one, which ought to be the only one
    return paths[0]
}
```

`UserDefaults` is not great for storing large amounts of data. The app's
documents directory is good for this, and it is sync'd to iCloud.

`write(to:)` method takes three parameters:
- A URL to write to.
- Whether to make the write atomic, which means “all at once”. (usually set to
  true)
- What character encoding to use.

```swift
let url = getDocumentsDirectory().appendingPathComponent("message.txt")

do {
  // write the string
  try str.write(to: url, atomically: true, encoding: .utf8)
  // read it back
  let input = try String(contentsOf: url)
} catch {
  outputOrError = error.localizedDescription
}
```

turn the func into an extension:
```swift
extension FileManager {
    static func userDocumentsDirectory() -> URL {
        // find all possible documents directories
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        //just use the first one, which should be the only one
        return paths[0]
    }
}
```

Showing Views Conditionally

Instead of using if statements with bools, use an enum for all of the
representations of state.

1. The first is to define an enum for the various view states you want to
   represent

```swift
enum LoadingState {
    case loading, success, failed
}
```

2. Next, create individual views for those states. I’m just going to use simple
   text views here, but they could hold anything:

```swift
struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}
```

3. use this in your content view:
```swift
struct ContentView: View {
    var loadingState = LoadingState.loading

    var body: some View {
        if loadingState == .loading {
            LoadingView()
        } else if loadingState == .success {
            SuccessView()
        } else {
            FailedView()
        }
    }
}
```

# Day 67
13 May
https://www.hackingwithswift.com/100/swiftui/67

Instafilter review / Challenges.

# Day 66
12 May
https://www.hackingwithswift.com/100/swiftui/66

# Day 65
12 May
https://www.hackingwithswift.com/100/swiftui/65

Instafilter project

# Day 64
11 May
https://www.hackingwithswift.com/100/swiftui/64

SwiftUI `Coordinators` are NOT UIKit coordinators.

SwiftUI’s coordinators are designed to act as delegates for UIKit view
controllers.

SwiftUI calls `makeCoordinator()` when it creates an instance of a
struct conforming to `UIViewControllerRepresentable` is created.

```swift
// up in makeUIViewController, set the delegate to the coordinator
picker.delegate = context.coordinator // this is set by makeCoordinator()

// this is so SwiftUI knows which Coordinator to use
func makeCoordinator() -> Coordinator {
    return Coordinator()
}

// Coordinator handles communication between the UIViewController
// (PHPickerViewController in this case) and SwiftUI
class Coordinator: NSObject, PHPickerViewControllerDelegate {
// add delegate methods
}
```

Write an image to photo library and handle callbacks, objective-c style:
```swift
class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}
```

- Mark the method using a special compiler directive called #selector, which
  asks Swift to make sure the method name exists where we say it does.
- Add an attribute called @objc to the method, which tells Swift to generate
  code that can be read by Objective-C.

# Day 63
11 May
https://www.hackingwithswift.com/100/swiftui/63

Images

- UIImage, which comes from UIKit. This is an extremely powerful image type
  capable of working with a variety of image types, including bitmaps (like
  PNG), vectors (like SVG), and even sequences that form an animation. UIImage
  is the standard image type for UIKit, and of the three it’s closest to
  SwiftUI’s Image type.
- CGImage, which comes from Core Graphics. This is a simpler image type that is
  really just a two-dimensional array of pixels.
- CIImage, which comes from Core Image. This stores all the information required
  to produce an image but doesn’t actually turn that into pixels unless it’s
  asked to. Apple calls CIImage “an image recipe” rather than an actual image.
  There is some interoperability between the various image types:

- We can create a UIImage from a CGImage, and create a CGImage from a UIImage.
- We can create a CIImage from a UIImage and from a CGImage, and can create a
  CGImage from a CIImage.
- We can create a SwiftUI Image from both a UIImage and a CGImage.

1. We need to load our example image into a UIImage
2. We’ll convert that into a CIImage, which is what Core Image wants to work
   with.

```swift
func loadImage() {
    guard let inputImage = UIImage(named: "Example") else { return }
    let beginImage = CIImage(image: inputImage)

    // more code to come
}
```

3. The next step will be to create a Core Image context and a Core Image filter

```swift
import CoreImage
import CoreImage.CIFilterBuiltins

let context = CIContext()
let currentFilter = CIFilter.sepiaTone()
```

4. customize our filter to change the way it works.

```swift
currentFilter.inputImage = beginImage
currentFilter.intensity = 1
```

5. we need to convert the output from our filter to a SwiftUI Image that we can
   display in our view
   - Read the output image from our filter, which will be a CIImage. This might fail, so it returns an optional.
   - Ask our context to create a CGImage from that output image. This also might fail, so again it returns an optional.
   - Convert that CGImage into a UIImage.
   - Convert that UIImage into a SwiftUI Image.

```swfit
// get a CIImage from our filter or exit if that fails
guard let outputImage = currentFilter.outputImage else { return }

// attempt to get a CGImage from our CIImage
if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
    // convert that to a UIImage
    let uiImage = UIImage(cgImage: cgimg)

    // and convert that to a SwiftUI image
    image = Image(uiImage: uiImage)
}
```

Using the old API:
Each filter you can ask whether it supports certain parameters and apply only if
so:
```swift
// ask the filter whether these params are supported and set them if so
let inputKeys = currentFilter.inputKeys
if inputKeys.contains(kCIInputIntensityKey) {
    currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
}
```

UIKit 101

- UIKit has a class called UIView, which is the parent class of all views in the
  layouts. So, labels, buttons, text fields, sliders, and so on – those are all
  views.
- UIKit has a class called UIViewController, which is designed to hold all the
  code to bring views to life. Just like UIView, UIViewController has many
  subclasses that do different kinds of work.
- UIKit uses a design pattern called delegation to decide where work happens.
  So, when it came to deciding how to respond to a text field changing, we’d
  create a custom class with our functionality and make that the delegate of our
  text field.

Create a struct that conforms to UIViewControllerRepresentable, which builds on
View but we don't need a Body property because that's handled by what UIKit
returns:
```swift
struct ImagePicker: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PHPickerViewController {
      var config = PHPickerConfiguration()
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
}
```

# Day 62
9 May
https://www.hackingwithswift.com/100/swiftui/62

@State internals:

this didSet will trigger when the value is changed directly, eg in a button, but
not when changed by a binding eg on a slider because bindings change the
underlying struct that makes @State work, not the struct itself.
```swift
@State private var blurAmount = 0.0 {
    didSet {
        print("New value is \(blurAmount)")
    }
}
```

How can we ensure some code is run whenever a binding is changed, no matter how
that change happens? with the `.onChange()` modifier.

```swift
@State private var blurAmount = 0.0

Slider(value: $blurAmount, in: 0...20)
    .onChange(of: blurAmount) { newValue in
        print("New value is \(newValue)")
    }
```

confirmationDialog(): an alternative to alert() that lets us add many buttons.

confirmation dialogs slide up from the bottom, can contain multiple buttons, and
can be dismissed by tapping on Cancel or by tapping outside of the options.

```swift
.confirmationDialog("Change background", isPresented: $showingConfirmation) {
    Button("Red") { backgroundColor = .red }
    Button("Green") { backgroundColor = .green }
    Button("Blue") { backgroundColor = .blue }
    Button("Cancel", role: .cancel) { }
} message: {
    Text("Select a new color")
}
```

# Day 61
9 May
https://www.hackingwithswift.com/100/swiftui/61

Add Core Data to Day 60's project.

Update CoreData on the main thread (when mixing async/await stuff):
```swift
await MainActor.run {
    // your work here
}
```

# Day 60
8 May
https://www.hackingwithswift.com/100/swiftui/60

FriendFace
Build an app that fetches JSON from the internet and displays.

# Day 59
7 May
https://www.hackingwithswift.com/100/swiftui/59

# Day 58
7 May
https://www.hackingwithswift.com/100/swiftui/58

Predicates allow you to control which results should be shows from a
@FetchRequest. Here universe is an attribute on Ship:
```swift
@FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == 'Star Wars'")) var ships: FetchedResults<Ship>
```

Can also provide params with `%@` if strings have quotes etc:
```swift
NSPredicate(format: "universe == %@", "Star Wars"))
```

Can also provide comparisons:
```swift
NSPredicate(format: "name < %@", "F"))
```

Can use IN to check for values in an array:
```swift
NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
```

Other examples
```swift
NSPredicate(format: "name BEGINSWITH %@", "E"))

// non case-sensitive version of above
NSPredicate(format: "name BEGINSWITH[c] %@", "e"))

// check whether a string contains a value
NSPredicate(format: "name CONTAINS[c] %@", "e"))

// invert with NOT
NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e"))
```

If you need more complicated predicates, join them using AND to build up as much
precision as you need, or add an import for Core Data and take a look at
NSCompoundPredicate – it lets you build one predicate out of several smaller
ones.

Dynamic Filtering

carve off the functionality we want into a separate view, then inject values
into it.

Because this view will be used inside ContentView, we don’t even need to inject
a managed object context into the environment – it will inherit the context from
ContentView.

In the view it needs a filter property and a custom initializer:

```swift
@FetchRequest var fetchRequest: FetchedResults<Singer>

init(filter: String) {
    _fetchRequest = FetchRequest<Singer>(
      sortDescriptors: [],
      predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter)
    )
}
```

Why the underscore on `_fetchRequest`? It completely replaces the existing
`fetchRequest` variable that's wrapped by `@FetchRequest`, instead of adding to
it (which would happen if we just did fetchRequest = blah). I don't fully get
this yet.

The call this new view:
```swift
FilteredView(filter: "A")
```

To filter on any field, and for any model type, see the `Want to go further?`
heading here
https://www.hackingwithswift.com/books/ios-swiftui/dynamically-filtering-fetchrequest-with-swiftui

passing a filter key into a predicate:
```swift
NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue)
```

Data Relationships

In core data model editor, can add relationships to other entities, specifiying
one to many etc in the inspector.

Need to make a custom NSManagedObject subclass for this to work with swift.

Convert NSSet to Array, so swiftui's ForEach works.

# Day 57
7 May
https://www.hackingwithswift.com/100/swiftui/57

Can either use CoreData's generated models or have it write one out to modify
the swift file: Editor -> CreateNSManagedObject Subclass. Also open the
inspector and change `Codegen` to none.

Always check a managed context for changes before actually saving:
```swift
if moc.hasChanges {
    try? moc.save()
}
```

CoreData can merge duplicate objects with a merge policy
```swift
container.loadPersistentStores { description, error in
    if let error = error {
        print("Core Data failed to load: \(error.localizedDescription)")
        return
    }

    self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
}
```

# Day 56
6 May
https://www.hackingwithswift.com/100/swiftui/56

# Day 55
6 May
https://www.hackingwithswift.com/100/swiftui/55

Setting up a preview when using Core Data:

jk this doesn't work. figure out why?
```swift
import CoreData

struct DetailView_Previews: PreviewProvider {
    static var dataController = DataController()

    static var previews: some View {
        let book = Book(context: dataController.container.viewContext)
        book.title = "test book"
        book.author = "test author"
        book.genre = "fantasy"
        book.rating = 4
        book.review = "test review"

        return NavigationView {
            DetailView(book: book)
        }
    }
}
```

using a constant binding makes a view read-only
```swift
RatingView(rating: .constant(Int(book.rating)))
```

Sort results from Core Data with a SortDescriptor (or multiple):
```swift
@FetchRequest(sortDescriptors: [
    SortDescriptor(\.title),
    SortDescriptor(\.author)
]) var books: FetchedResults<Book>
```

Sorting is done in ascending order by default. To reverse:
```swift
SortDescriptor(\.title, order: .reverse)
```

Showing an alert to confirm deletion:
```swift
.alert("Delete Book", isPresented: $showingDeleteAlert) {
    Button("Delete", role: .destructive, action: deleteBook)
    Button("Cancel", role: .cancel) { }
} message: {
    Text("Are you sure?")
}
```

# Day 54
5 May
https://www.hackingwithswift.com/100/swiftui/54

`constant bindings`. These are bindings that have fixed values, which on the one
hand means they can’t be changed in the UI, but also means we can create them
trivially – they are perfect for previews

```swift
static var previews: some View {
    RatingView(rating: .constant(4))
}
```

# Day 53
3 May
https://www.hackingwithswift.com/100/swiftui/53

`@Binding`

Lets us connect an @State property of one view to some underlying model
data. It lets us store a mutable value in a view that actually points to some
other value from elsewhere

`@State` property wrapper lets us work with local value types (structs).
`@StateObject` lets us work with shareable reference types (classes)

@Binding is extremely important for whenever you want to create a custom user
interface component.

@Binding allows us to create a two-way connection between the view it's being
declared in and the view that container the former view.

In the child view use this:
```swift
@Binding var isOn: Bool
```

In the parent view you'll have
```swift
@State private var rememberMe = false
// etc view stuff then when using pass as binding:
PushButton(title: "Remember Me", isOn: $rememberMe)
```

`TextEditor`

be careful to make sure it doesn’t go outside the safe area, otherwise typing
will be tricky; embed it in a NavigationView, a Form, or similar.

Core Data

Setup:
1. defining the data we want to use in our app. Create a Data Model file
   `Bookworm`. Give it an entity with some attributes.
2. writing a little Swift code to load that model and prepare it for us to use.
```swift
import CoreData

class DataController: ObservableObject {
  let container = NSPersistentContainer(name: "Bookworm")
}
```
3. loadPersistentStores() on our container, which tells Core Data to access our
   saved data according to the data model in Bookworm.xcdatamodeld
```swift
init() {
    container.loadPersistentStores { description, error in
        if let error = error {
            print("Core data failed to load: \(error.localizedDescription)")
        }
    }
}
```
4. create an instance of DataController and send it into SwiftUI’s environment
```swift
// in BookWormApp.swift, where the @main thing is

// this loads the core data model once
@StateObject private var dataController = DataController()

var body: some Scene {
    WindowGroup {
        ContentView()
            // set the container on the Environment object
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}
```

Managed Object Contexts effectively the “live” version of your data – when you
load objects and change them, those changes only exist in memory until you
specifically save them back to the persistent store.

the job of the view context is to let us work with all our data in memory, which
is much faster than constantly reading and writing data to disk. When we’re
ready we still do need to write changes out to persistent store if we want them
to be there when our app runs next, but you can also choose to discard changes
if you don’t want them.

Fetch Request

Retrieving information from Core Data is done using a fetch request
```swift
@FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
```
that creates a fetch request with no sorting, and places it into a property
called students that has the the type FetchedResults<Student>.

For adding and saving objects, need access to the Managed Object Context:
```swift
@Environment(\.managedObjectContext) var moc
```

Then can create using the class Core Data generated
```swift
let student = Student(context: moc)

try? moc.save()
```

# Day 52
2 May
https://www.hackingwithswift.com/100/swiftui/52

Challenges

# Day 51
2 May
https://www.hackingwithswift.com/100/swiftui/51

`Task` can be used inside eg a Button, since the `.task` modifier can't be used
in that scenario.

```swift
Button("Place Order") {
  Task {
    await placeOrder()
  }
}
```

Making HTTP POST requests:

```swift
func placeOrder() async {
    guard let encoded = try? JSONEncoder().encode(order) else {
        print("failed to encode order")
        return
    }

    let url = URL(string: "https://reqres.in/api/cupcakes")!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"

    do {
        let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
        let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
        confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
        showingConfirmation = true
    } catch {
        print("error uploading data")
    }
}
```

# Day 50
1 May
https://www.hackingwithswift.com/100/swiftui/50

# Day 49
1 May
https://www.hackingwithswift.com/100/swiftui/49

If all the properties of a type already conform to Codable, then the type itself
can conform to Codable with no extra work. However, this doesn’t work when we
use property wrappers such as @Published.

this compiles just fine:
```swift
class User: ObservableObject, Codable {
    var name = "Paul Hudson"
}
```

however this does not:

```swift
class User: ObservableObject, Codable {
    @Published var name = "Paul Hudson"
}
```

@Published is a struct called Published that can store any kind of value. you
can’t make an instance of Published all by itself, but instead make an instance
of Published<String> – a publishable object that contains a string.

To confirm @Published to Codable, we need to tell Swift which properties should
be loaded and saved, and how to do both of those actions.

This is done using an enum that conforms to a special protocol called CodingKey,
which means that every case in our enum is the name of a property we want to
load and save. This enum is conventionally called CodingKeys, with an S on the
end, but you can call it something else if you want.

add that to the Class:
```swift
class User: ObservableObject, Codable {
    // step 1: add the enum
    enum CodingKeys: CodingKey {
        case name
    }

    @Published var name = "Paul Hudson"

    // step 2: create a custom initializer that will be given some sort of
    container, and use that to read values for all our properties.
    required init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }

    // step 3: add an encoding method to do the opposite of init
    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}
```

anyone who subclasses our User class must override this initializer with a
custom implementation to make sure they add their own values. We mark this using
the required keyword: required init. An alternative is to mark this class as
final so that subclassing isn’t allowed, in which case we’d write final class
User and drop the required keyword entirely.

Asynchronous Functions

we can’t just use onAppear() here because that doesn’t know how to handle
sleeping functions – it expects its function to be synchronous.

```swift
func loadData() async { }
```

instead add a task modifier to the view:

```swift
.task {
    await loadData()
}
```

Making an HTTP Request

1. parse a URL

```swift
guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
    print("Invalid URL")
    return
}
```

2: make the request
```swift
do {
    let (data, _) = try await URLSession.shared.data(from: url)

    // more code to come
} catch {
    print("Invalid data")
}
```

URLSession.data(from:) returns a tuple containing the data from the request and
metadata about the request.

3. convert data into an struct

```swift
// this goes in 'more code to come' above
if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
    results = decodedResponse.results
}
```

AsyncImage

```swift
AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"))
```

Caveat: SwiftUI knows nothing about the image until our code is run and the
image is downloaded, and so it isn’t able to size it appropriately ahead of
time.

tell SwiftUI ahead of time that we’re trying to load a 3x scale image
```swift
AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
```

`resizable()` and `frame()` don't work because SwiftUI doesn't know what the
image looks like until it's downloaded.

Use this version of AsyncImage, which takes a closure that passes in the
resulting Image view:

```swift
AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
    image
        .resizable()
        .scaledToFit()
} placeholder: {
    Color.red // or ProgressView()
}
.frame(width: 200, height: 200)
```

use this version to catch any errors on download:

```swift
AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
    if let image = phase.image {
        image
            .resizable()
            .scaledToFit()
    } else if phase.error != nil {
        Text("There was an error loading the image.")
    } else {
        ProgressView()
    }
}
.frame(width: 200, height: 200)
```

disabled() view modifier ... disables input views.

`.disabled(username.isEmpty || email.isEmpty)`

Can also make a computed property
```swift
var disableForm: Bool {
    username.count < 5 || email.count < 5
}
```

# Day 48
29 April
https://www.hackingwithswift.com/100/swiftui/48

watching a presentation video

# Day 47
29 April
https://www.hackingwithswift.com/100/swiftui/47

Habit tracking app challenge

# Day 46
29 April
https://www.hackingwithswift.com/100/swiftui/46

Challenges

# Day 45
29 April
https://www.hackingwithswift.com/100/swiftui/45

Blend modes allow us to control the way one view is rendered on top of another.
The default mode is .normal, which just draws the pixels from the new view onto
whatever is behind.

`Multiply` is so named because it multiplies each source pixel color with the
destination pixel color

The long way:
```swift
ZStack {
  Image("river")

    Rectangle()
    .fill(.red)
    .blendMode(.multiply)
}
```

The short way:
```swift
Image("river")
    .colorMultiply(.red)
```

`screen`, which does the opposite of multiply: it inverts the colors, performs a
multiply, then inverts them again, resulting in a brighter image rather than a
darker image.

saturation(), which adjusts how much color is used inside a view. Give this a
value between 0 (no color, just grayscale) and 1 (full color)

`animatableData`

When animating changes to a Shape using `withAnimation { }`, add an
`animatableData` property to the Shape. SwiftUI will pass the interpolated
values for the animation to this property so the animation actually occurs.
Otherwise it just changes directly from one value to the other.

```swift
var insetAmount: Double
var animatableData: Double {
    get { insetAmount }
    set { insetAmount = newValue }
}
```

`AnimatablePair`

As its name suggests, this contains a pair of animatable values,
and because both its values can be animated the AnimatablePair can itself be
animated. We can read individual values from the pair using .first and .second.

```swift
var animatableData: AnimatablePair<Double, Double> {
    get {
       AnimatablePair(Double(rows), Double(columns))
    }

    set {
        rows = Int(newValue.first)
        columns = Int(newValue.second)
    }
}
```

To animate a bunch of properties chain them

```swift
AnimatablePair<CGFloat, AnimatablePair<CGFloat, AnimatablePair<CGFloat, CGFloat>>>
```

# Day 44
28 April
https://www.hackingwithswift.com/100/swiftui/44

`CGAffineTransform`, which describes how a path or view should be rotated, scaled,
or sheared; and the second is `even-odd fills`, which allow us to control how
overlapping shapes should be rendered.

even-odd fills:
`.fill(.red, style: FillStyle(eoFill: true))`

`ImagePaint`

dedicated type that wraps images in a way that we have complete control over
how they should be rendered, which in turn means we can use them for borders
and fills without problem

To use an image as a border:
```swift
Text("Hello World")
    .frame(width: 300, height: 300)
    .border(ImagePaint(image: Image("Example"), scale: 0.2), width: 30)
```

`drawingGroup()` modifier tells swiftui to render offscren using Metal

# Day 43
28 April
https://www.hackingwithswift.com/100/swiftui/43

Paths

To draw a triangle:
```swift
Path { path in
    path.move(to: CGPoint(x: 200, y: 100))
    path.addLine(to: CGPoint(x: 100, y: 300))
    path.addLine(to: CGPoint(x: 300, y: 300))
    path.addLine(to: CGPoint(x: 200, y: 100))
}
```

closing paths for stroking. Either `path.closeSubpath()` or
```swift
.stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
```

SwiftUI enables custom drawing with two subtly different types: paths and
shapes. A path is a series of drawing instructions such as “start here, draw a
line to here, then add a circle there”, all using absolute coordinates. In
contrast, a shape has no idea where it will be used or how big it will be used,
but instead will be asked to draw itself inside a given rectangle.

SwiftUI implements Shape as a protocol with a single required method: given the
following rectangle, what path do you want to draw?

Triangle implemented using Shape, so it uses all free space available:
```swift
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

// use with
Triangle()
    .fill(.red)
    .frame(width: 300, height: 300)
```

- In the eyes of SwiftUI 0 degrees is not straight upwards, but instead directly
  to the right.
- Shapes measure their coordinates from the bottom-left corner rather than the
  top-left corner, which means SwiftUI goes the other way around from one angle
  to the other. This is, in my not very humble opinion, extremely alien.
- If you create a shape without a specific size, it will automatically expand to
  occupy all available space.

`stroke(.blue, lineWidth: 10)` draws like a marker half on one side of the line
half on the other. So the view may be cut off. Use `strokeBorder` instead, which
draws on the inside of the shape's line.

`InsettableShape`. This is a shape that can be inset – reduced inwards – by a
certain amount to produce another shape.

# Day 42
27 April
https://www.hackingwithswift.com/100/swiftui/42

aspectRatio(contentMode: .fit) is the same as scaledToFit()

dateFormat allows us to specify a precise format for our dates, whereas
dateStyle has a selection of built-in formats that match the user's settings.

# Day 41
27 April
https://www.hackingwithswift.com/100/swiftui/41

Placing a VStack inside another VStack allows us to control alignment for one
specific part of our view – our main mission image can be centered, while the
mission details can be aligned to the leading edge.

# Day 40
26 April
https://www.hackingwithswift.com/100/swiftui/40

`Codable` is needed on a struct to encode/decode JSON.

Embedded structs keep types clean and allows for namespacing.

```swift
struct CrewRole { }

struct Mission { }

// or

struct Mission {
  // refer to this as Mission.CrewRole
  struct CrewRole { }
}
```

Generics

to make this generic:
```swift
    func decode(_ file: String) -> [String: Astronaut] {
```

Do this:
```swift
    func decode<T>(_ file: String) -> T {
```

Make `<T`> constrained to only types that are `Codable`:
```swift
func decode<T: Codable>
```

Then when using the func, need to specify types (type annotation):

```swift
let astronauts: [String: Astronaut] = Bundle.main.decode("a.json")
```

> Codable is just an alias for two separate protocols: Encodable and Decodable

JSONDecoder type has a property called dateDecodingStrategy, which determines
how it should decode dates. We can provide that with a DateFormatter instance
that describes how our dates are formatted.

`ShapeStyle` protocol

Color conforms to a bigger protocol called ShapeStyle that is what lets us use
colors, gradients, materials, and more as if they were the same thing.

This ShapeStyle protocol is what the background() modifier uses, so what we
really want to do is extend Color but do so in a way that all the SwiftUI
modifiers using ShapeStyle work too:

make an extension only if the type is Color:
```swift
extension ShapeStyle where Self == Color {
```

To force dark mode:
`.preferredColorScheme(.dark)`

# Day 39
25 April
https://www.hackingwithswift.com/100/swiftui/39

GeometryReader

> When we create an Image view in SwiftUI, it will automatically size itself
> according to the dimensions of its contents. So, if the picture is 1000x500,
> the Image view will also be 1000x500.

> how we can make an image fit some amount of the user’s screen width using a
> new view type called GeometryReader.

To resize an image this won't work:

```swift
Image("Example")
    .frame(width: 300, height: 300)
```

because the content (the image) is still bigger than the frame.

Can use clipped, but it crops the image into the frame:

```swift
Image("Example")
    .frame(width: 300, height: 300)
    .clipped()
```

Can use `resizable()` but that squishes the image into the frame, which could
mess up the aspect ratio

```
Image("Example")
    .resizable()
    .frame(width: 300, height: 300)
```

> To fix this we need to ask the image to resize itself proportionally, which
> can be done using the scaledToFit() and scaledToFill() modifiers. The first of
> these means the entire image will fit inside the container even if that means
> leaving some parts of the view empty, and the second means the view will have
> no empty parts even if that means some of our image lies outside the
> container.

```swift
// fit
Image("Example")
    .resizable()
    .scaledToFit()
    .frame(width: 300, height: 300)
// or fill
Image("Example")
    .resizable()
    .scaledToFill()
    .frame(width: 300, height: 300)
```

> All this works great if we want fixed-sized images, but very often you want
> images that automatically scale up to fill more of the screen in one or both
> dimensions. That is, rather than hard-coding a width of 300, what you really
> want to say is “make this image fill 80% of the width of the screen.”

> GeometryReader is a view just like the others we’ve used, except when we
> create it we’ll be handed a GeometryProxy object to use. This lets us query
> the environment: how big is the container? What position is our view? Are
> there any safe area insets? And so on.

> In principle that seems simple enough, but in practice you need to use
> GeometryReader carefully because it automatically expands to take up available
> space in your layout, then positions its own content aligned to the top-left
> corner.

An image that is 80% the width, with fixed height of 300
```swift
GeometryReader { geo in
    Image("Example")
        .resizable()
        .scaledToFit()
        .frame(width: geo.size.width * 0.8, height: 300)
}
```

> Tip: If you ever want to center a view inside a GeometryReader, rather than
> aligning to the top-left corner, add a second frame that makes it fill the
> full space of the container, like this:

```swift
GeometryReader { geo in
    Image("Example")
        .resizable()
        .scaledToFit()
        .frame(width: geo.size.width * 0.8)
        .frame(width: geo.size.width, height: geo.size.height)
}
```

ScrollView

Scroll views can scroll horizontally, vertically, or in both directions, and you
can also control whether the system should show scroll indicators next to them

there’s an important catch that you need to be aware of: when we add views to a
scroll view they get created immediately.

If you want to avoid this happening, there’s an alternative for both VStack and
HStack called LazyVStack and LazyHStack. These will load their content on-demand
– they won’t create views until they are actually shown.

there is one important layout difference: lazy stacks always take up as much as
room as is available in our layouts, whereas regular stacks take up only as much
space as is needed. Regular stacks need `.frame(maxWidth: .infinity)`.

Horizontal ScrollView:
```swift
ScrollView(.horizontal) {
    LazyHStack(spacing: 10) {
```

Vertical ScrollView:
```swift
ScrollView {
    LazyVStack(spacing: 10) {
```

NavigationLink

NavigationLink: give this a destination and something that can be tapped and it
will push a view onto the NavigationView stack

This starts with `Hello, World`. When tapped, it pushes `Detail View` onto the
stack:
```swift
NavigationView {
    NavigationLink {
        Text("Detail View")
    } label: {
        Text("Hello, world!")
            .padding()
    }
    .navigationTitle("SwiftUI")
}
```

JSONDecoder for custom types

Given this input
```json
{
    "name": "Taylor Swift",
    "address": {
        "street": "555, Taylor Swift Avenue",
        "city": "Nashville"
    }
}
```

Create these structs
```swift
struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}
```

and decode with

```swift
let data = Data(input.utf8)
let decoder = JSONDecoder()
if let user = try? decoder.decode(User.self, from: data) {
    print(user.address.street)
}
```

LazyHGrid and LazyVGrid

> columns of data – a grid of information, that is able to adapt to show more
> data on larger screens

Creating a grid is done in two steps. First, we need to define the rows or
columns we want – we only define one of the two, depending on which kind of grid
we want.

vertically scrolling grid: we want our data laid out in three columns exactly 80
points wide
```swift
let layout = [
    GridItem(.fixed(80)),
    GridItem(.fixed(80)),
    GridItem(.fixed(80))
]
```

place your grid inside a ScrollView, along with as many items as you want. Each
item you create inside the grid is automatically assigned a column in the same
way that rows inside a list automatically get placed inside their parent.
```swift
ScrollView {
    LazyVGrid(columns: layout) {
        ForEach(0..<1000) {
            Text("Item \($0)")
        }
    }
}
```

fit in as many columns as possible, as long as they are at least 80 points in
width:
```swift
GridItem(.adaptive(minimum: 80))
```

set a max for more control:
```swift
GridItem(.adaptive(minimum: 80, maximum: 120))
```

Horizontal rows:
```swift
ScrollView(.horizontal) {
    LazyHGrid(rows: layout) {
```

# Day 38
25 April
https://www.hackingwithswift.com/100/swiftui/38

Get a users's Locale and various settings therin (currency code, language, etc)
https://developer.apple.com/documentation/foundation/nslocale

# Day 37
24 April
https://www.hackingwithswift.com/100/swiftui/37

UUID

`let id = UUID()`

Identifiable Protocol

>  means “this type can be identified uniquely.” It has only one requirement,
>  which is that there must be a property called id that contains a unique
>  identifier

When using, no need for `id` param on `ForEach`

JSON Decoder:

```swift
// get data from UserDefaults or wherever
JSONDecoder.decode([String].self, from: data)
```

What is `[String].self`?
we’re referring to the type itself, known as the type object – we write .self
after it.
It's there so the decoder knows what type to decode into.

# Day 36
24 April
https://www.hackingwithswift.com/100/swiftui/36

https://www.hackingwithswift.com/articles/227/which-swiftui-property-wrapper

`@State` monitors a var for changes and reloads the body as necessary. If a var
marked with `@State` is a `class` instead of a `struct`, it cannot monitor
changes since classes are mutable so the desired behavior doesn't happen.

> If you want to use a class with your SwiftUI data then SwiftUI gives us three
> property wrappers that are useful: @StateObject, @ObservedObject, and
> @EnvironmentObject.

we need to tell SwiftUI when interesting parts of our class have changed. We can
do this using the @Published property observer

`@Published` is more or less half of @State: it tells Swift that whenever either
of those two properties changes, it should send an announcement out to any
SwiftUI views that are watching that they should reload.

`@StateObject`, which is the other half of @State – it tells SwiftUI that we’re
creating a new class instance that should be watched for any change
announcements.

the @StateObject property wrapper can only be used on types that conform to the
ObservableObject protocol.

```swift
class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

// down in view stuff
@StateObject var user = User()
```

As you’ve seen, rather than just using @State to declare local state, we now
take three steps:

- Make a class that conforms to the ObservableObject protocol.
- Mark some properties with @Published so that any views using the class get
  updated when they change.
- Create an instance of our class using the @StateObject property wrapper.

When you want to use a class instance elsewhere – when you’ve created it in view
A using @StateObject and want to use that same object in view B – you use a
slightly different property wrapper called @ObservedObject. That’s the only
difference: when creating the shared data use @StateObject, but when you’re just
using it in a different view you should use @ObservedObject instead.

Sheets

Showing a sheet requires four steps:

- we need some state to track whether the sheet is showing `@State private var
  showingSheet = false`
- we need to toggle that when our button is tapped `showingSheet.toggle()`
- we need to attach our sheet somewhere to our view hierarchy
- we need to decide what should actually be in the sheet

```swift
.sheet(isPresented: $showingSheet) {
    // contents of the sheet
    SecondView()
}
```

`@Environment` allows us to create properties that store values provided
to us externally. Is the user in light mode or dark mode? Have they asked for
smaller or larger fonts? What timezone are they on?

> we’re effectively saying “hey, figure out how my view was presented, then
> dismiss it appropriately.”

```swift
struct SecondView: View {
    let name: String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button("Hello, \(name)") {
            dismiss()
        }
    }
}
```

onDelete()

this is almost exclusively used with List and ForEach: we create a list of rows
that are shown using ForEach, then attach onDelete() to that ForEach so the user
can remove rows they don’t want

the onDelete() modifier only exists on ForEach, so if we want users to delete
items from a list we must put the items inside a ForEach.

In order to make onDelete() work, we need to implement a method that will
receive a single parameter of type IndexSet

```swift
ForEach(numbers, id: \.self) {
    Text("Row \($0)")
}
.onDelete(perform: removeRows)

// later on make this func
func removeRows(at offsets: IndexSet) {
  numbers.remove(atOffsets: offsets)
}
```

add an Edit/Done button to the navigation bar, that lets users delete several
rows more easily.

First, wrap your VStack in a NavigationView, then add this modifier to the
VStack:

```swift
.toolbar {
    EditButton()
}
```

UserDefaults

One common way to store a small amount of data is called UserDefaults

everything you store in UserDefaults will automatically be loaded when your app
launches – if you store a lot in there your app launch will slow down. To give
you at least an idea, you should aim to store no more than 512KB in there.

SwiftUI can often wrap up UserDefaults inside a nice and simple property wrapper
called @AppStorage – it only supports a subset of functionality right now, but
it can be really helpful.

```swift
UserDefaults.standard.set(self.tapCount, forKey: "Tap")
```

1. use UserDefaults.standard. This is the built-in instance of UserDefaults that
   is attached to our app, but in more advanced apps you can create your own
   instances. For example, if you want to share defaults across several app
   extensions you might create your own UserDefaults instance
2. There is a single set() method that accepts any kind of data – integers,
   Booleans, strings, and more.
3. We attach a string name to this data, in our case it’s the key “Tap”. This
   key is case-sensitive,
4. it takes iOS a little time to write your data to permanent storage

Reading back out:
```swift
@State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
```

if the key can’t be found it just sends back 0.

`@AppStorage`

SwiftUI provides an @AppStorage property wrapper around UserDefaults:

```swift
struct ContentView: View {
    @AppStorage("tapCount") private var tapCount = 0

    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
        }
    }
}
```

1. access to the UserDefaults system is through the @AppStorage property
   wrapper. This works like @State: when the value changes, it will reinvoked
   the body property so our UI reflects the new data.
2. We attach a string name, which is the UserDefaults key where we want to store
   the data

right now at least @AppStorage doesn’t make it easy to handle storing complex
objects such as Swift structs

Codable

Codable: a protocol specifically for archiving and unarchiving data

When working with a type that only has simple properties – strings, integers,
Booleans, arrays of strings, and so on – the only thing we need to do to support
archiving and unarchiving is add a conformance to Codable.

```swift
let encoder = JSONEncoder()

if let data = try? encoder.encode(user) {
    UserDefaults.standard.set(data, forKey: "UserData")
}
```

# Day 35
23 April
https://www.hackingwithswift.com/100/swiftui/35

Multiplication Tables game.

# Day 34
23 April
https://www.hackingwithswift.com/100/swiftui/34

# Day 33
22 April
https://www.hackingwithswift.com/100/swiftui/33

only changes that occur before the animation() modifier get animated

if we apply multiple animation() modifiers, each one controls everything before
it up to the next animation

it’s possible to disable animations entirely by passing nil to the modifier
`.animation(nil, value: enabled)`

`.offset` modifier adjusts the x and y offset of a view.

`DragGesture`

> Drag gestures have two extra modifiers that are useful to us here: onChanged()
> lets us run a closure whenever the user moves their finger, and onEnded() lets
> us run a closure when the user lifts their finger off the screen, ending the
> drag

```swift
// @State private var dragAmount = CGSize.zero
.gesture(
    DragGesture()
        .onChanged { dragAmount = $0.translation }
        .onEnded { _ in dragAmount = .zero }
)
```

implicitly animate both the dragging and the snapping back:
`.animation(.spring(), value: dragAmount)`

explicitly animate the snap back:

```swift
.onEnded { _ in
    withAnimation(.spring()) {
        dragAmount = .zero
    }
}
```

customize the way views are shown and hidden with transitions.

use `.transition` to change how a view animates.

use asymmetric to use one transition during showing, another during hiding
`.transition(.asymmetric(insertion: .scale, removal: .opacity))`

Creating custom transitions

rotationEffect() is similar to rotation3DEffect(), except it always rotates
around the Z axis. it also gives us the ability to control the anchor point of
the rotation

# Day 32
21 April
https://www.hackingwithswift.com/100/swiftui/32

`scaleEffect()` modifier:

provide this with a value from 0 up, and it will be drawn at that size – a value
of 1.0 is equivalent to 100%, i.e. the button’s normal size

create an implicit animation for our changes so that all the scaling happens
smoothly by adding an `animation()` modifier to the button.

`.animation(.default, value: animationAmount)`

That implicit animation takes effect on all properties of the view that change

ease in, ease out animation by default.

other options exist
`.animation(.easeOut, value: animationAmount)`

Spring animation

```swift
.animation(.interpolatingSpring(
                  stiffness: 50,
                  damping: 1
                  ),
                  value: animationAmount)
```

change the duration
`.animation(.easeInOut(duration: 2), value: animationAmount)`

can also set a delay

```swift
.animation(
    .easeInOut(duration: 2)
        .delay(1), // delay is another modifier
    value: animationAmount
)
```

repeat animations:
```swift
.animation(
    .easeInOut(duration: 1)
        .repeatCount(3, autoreverses: true),
    value: animationAmount
)
```

continuous
```swift
.animation(
    .easeInOut(duration: 1)
        .repeatForever(autoreverses: true),
    value: animationAmount
)
```

Can add overlays to views, and animate forever with `onAppear`:
```swift
        .overlay {
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeOut(duration: 1)
                    .repeatForever(autoreverses: false),
                    value: animationAmount
                )
        }
        .onAppear {
            animationAmount = 2
        }
```

The animation() modifier can be applied to any SwiftUI binding, which causes the
value to animate between its current and new value

Can bind a stepper to an animation:

```swift
@State private var animationAmount = 1.0

// view body stuff
Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
```

SwiftUI is examining the state of our view before the binding changes, examining
the target state of our views after the binding changes, then applying an
animation to get from point A to point

Can bind animations directly by adding a modifier to a view:
```swift
Stepper("Scale amount", value: $animationAmount.animation(
    .easeInOut(duration: 1)
        .repeatCount(3, autoreverses: true)
), in: 1...10)
```

rotation3DEffect(), which can be given a rotation amount in degrees as well as
an axis that determines how the view rotates

`.rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))`

If we just write animationAmount += 360 then the change will happen immediately,
because there is no animation modifier attached to the button. This is where
explicit animations come in: if we use a withAnimation() closure then SwiftUI
will ensure any changes resulting from the new state will automatically be
animated.

```swift
withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
    animationAmount += 360
}
```

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
