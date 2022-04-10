// https://www.hackingwithswift.com/100/swiftui/13
import Cocoa

// protocols

protocol Vehicle {
    // protocols can have methods AND properties
    var name: String { get } // must be readable
    var currentPassengers: Int { get set } // must be read-write eg not constant
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

// structs, classes, and enums can conform to protocols

// protocols are conformed the same way classes are inherited from
// if you need to subclass, list that first followed by protocols comma-separated
struct Car: Vehicle {
    let name = "Car"
    var currentPassengers = 1

    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }

    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }

    func openSunroof() {
        print("It's a nice day")
    }
}

func commute(distance: Int, using vehicle: Vehicle) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("too slow")
    } else {
        vehicle.travel(distance: distance)
    }
}

let car = Car()
commute(distance: 100, using: car)


// opaque return types


// Both Int and Bool conform to a common Swift protocol called Equatable, which means “can be compared for equality.” The Equatable protocol is what allows us to use ==
/*
// does not compile because types
func getRandomNumber() -> Int {
    Int.random(in: 1...6)
}

func getRandomBool() -> Bool {
    Bool.random()
}
 print(getRandomNumber() == getRandomBool())
 */

/*
 also won't compile because reasons
func getRandomNumber() -> Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> Equatable {
    Bool.random()
}
 */

// use opaque return types: add 'some' before the protocol
// swift knows that this returns an Int so it will type check all uses to verfy
// type safety
/*
 returning Vehicle means "any sort of Vehicle type but we don't know what",
 whereas returning some Vehicle means "a specific sort of Vehicle type but we
 don't want to say which one.”
 */
func getRandomNumber() -> some Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}

print(getRandomNumber() == getRandomNumber())

/*
 WHYYYY??

 SwiftUI needs to know exactly what kind of layout you want to show on the screen, and so we write code to describe it.

 In English, we might say something like this: “there’s a screen with a toolbar at the top, a tab bar at the bottom, and in the middle is a scrolling grid of color icons, each of which has a label below saying what the icon means written in a bold font, and when you tap an icon a message appears.”

 When SwiftUI asks for our layout, that description – the whole thing – becomes the return type for the layout. We need to be explicit about every single thing we want to show on the screen, including positions, colors, font sizes, and more. Can you imagine typing that as your return type? It would be a mile long! And every time you changed the code to generate your layout, you’d need to change the return type to match.

 This is where opaque return types come to the rescue: we can return the type some View, which means that some kind of view screen will be returned but we don’t want to have to write out its mile-long type. At the same time, Swift knows the real underlying type because that’s how opaque return types work: Swift always knows the exact type of data being sent back, and SwiftUI will use that create its layouts.
 */

// extensions
// add functionality to any type, whether we created the type or not

var quote = "   The truth is rarely pure and never simple   "
// to trim whitespace
let trimmed = quote.trimmingCharacters(in: .whitespacesAndNewlines)

// write an extention to shorten this
extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

let etrimmed = quote.trimmed()
print(etrimmed)

/*
 the extension has a number of benefits over the global function, including:

When you type quote. Xcode brings up a list of methods on the string, including all the ones we add in extensions. This makes our extra functionality easy to find.
Writing global functions makes your code rather messy – they are hard to organize and hard to keep track of. On the other hand, extensions are naturally grouped by the data type they are extending.
Because your extension methods are a full part of the original type, they get full access to the type’s internal data. That means they can use properties and methods marked with private access control, for example.
What’s more, extensions make it easier to modify values in place – i.e., to change a value directly, rather than return a new value.
 */

// for instance, if we wanted to modify to string directly we could add:
extension String {
    mutating func trim() {
        self = self.trimmed()
    }
}

quote.trim()
print(quote)

//  if you’re returning a new value rather than changing it in place, you should use word endings like ed or ing, like reversed().

// You can also use extensions to add properties to types, but there is one rule: they must only be computed properties, not stored properties.
extension String {
    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
}

let lyrics = """
But I keep cruising
Can't stop, won't stop moving
It's like I got this music in my mind
Saying it's gonna be alright
"""

print(lyrics.lines.count)

// how else this is useful:
// creating your own initializer means that Swift will no longer provide the memberwise one for us.
// However, sometimes you want both – you want the ability to use a custom initializer, but also retain Swift’s automatic memberwise initializer
// if we wanted our Book struct to have the default memberwise initializer as well as our custom initializer, we’d place the custom one in an extension
struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int
}

extension Book {
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}

// can still use the generated initializer
let lotr = Book(title: "Lord of the Rings", pageCount: 1178, readingHours: 24)

// protocol extensions
let guests = ["Mario", "Luigi", "Peach"]

extension Array {
    var isNotEmptyArray: Bool {
        isEmpty == false
    }
}
if guests.isNotEmptyArray {
    // meh
}

// nice to have on arrays, but what about sets and dictionaries?'
// write an extension to the Collection protocol, to which they all adhere
extension Collection {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}
if guests.isNotEmpty {
    print("meh")
}

//  protocol-oriented programming
// we can list some required methods in a protocol, then add default implementations of those inside a protocol extension. All conforming types then get to use those default implementations, or provide their own as needed.


protocol Person {
    var name: String {get}
    func sayHello()
}

// can add a default implementation
extension Person {
    func sayHello() {
        print("Hi, I'm \(name)")
    }
}
// conforming types can add their own sayHello() method if they want, but they don’t need to
struct Employee: Person {
    let name: String
}
let taylor = Employee(name: "Taylor Swift")
// uses the protocol extension by default:
taylor.sayHello()

/*
 Your challenge is this: make a protocol that describes a building, adding various properties and methods, then create two structs, House and Office, that conform to it. Your protocol should require the following:

 A property storing how many rooms it has.
 A property storing the cost as an integer (e.g. 500,000 for a building costing $500,000.)
 A property storing the name of the estate agent responsible for selling the building.
 A method for printing the sales summary of the building, describing what it is along with its other properties.
 */

protocol Building {
    var rooms: Int { get }
    var cost: Int { get }
    var agentName: String { get }
    func salesSummary()
}

struct House: Building {
    var rooms: Int
    var bathrooms: Int
    var cost: Int
    var agentName: String

    func salesSummary() {
        print("This is \(rooms) bed \(bathrooms) bath house selling for \(cost). Contact \(agentName) for information.")
    }
}

struct Office: Building {
    var rooms: Int
    var floors: Int
    var cost: Int
    var agentName: String

    func salesSummary() {
        print("This is \(rooms) room \(floors) floor office building selling for \(cost). Contact \(agentName) for information.")
    }
}

let house = House(rooms: 3, bathrooms: 2, cost: 500_000, agentName: "Lauren")
house.salesSummary()

