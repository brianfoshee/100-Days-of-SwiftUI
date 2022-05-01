Goal: be done by memorial day. Which is 56 days total.

[Glossary of Swift Terms](https://www.hackingwithswift.com/glossary)
[SwiftUI By Example](https://www.hackingwithswift.com/quick-start/swiftui)

# Day 49
30 April
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
