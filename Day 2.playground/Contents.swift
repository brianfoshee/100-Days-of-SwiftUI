// https://www.hackingwithswift.com/100/swiftui/2
import UIKit

let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

// make an array out of the variables
// using type interence:
// let beatles = [john, paul, george, ringo]
// use type annotations:
let beatles: [String] = [john, paul, george, ringo]

beatles[1]

// Sets vs arrays:
// 1. Items aren’t stored in any order; they are stored in what is effectively a random order.
// 2. No item can appear twice in a set; all items must be unique.

// Create a set directly from an array:
let colors = Set(["red", "green", "blue"])
// duplicate values are ignored
let colors2 = Set(["red", "green", "blue", "red"])

// Tuples vs Arrays
// 1. You can’t add or remove items from a tuple; they are fixed in size.
// 2. You can’t change the type of items in a tuple; they always have the same types they were created with.
// 3. You can access items in a tuple using numerical positions or by naming them, but Swift won’t let you read numbers or names that don’t exist.

// create a tuple by inserting values into parenthesis
var name = (first: "Taylor", last: "Swift")

// access values either by numerical position starting at 0
name.0

// ... or access using the item's name
name.first

// dictionaries
// declare using type annotation
let heights: [String: Double] = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]

// access with the key
heights["Taylor Swift"]

// default vaules in a dictionary
let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]

// no value for Charlotte so nil is returned
favoriteIceCream["Charlotte"]

// can give a default value to use instead
favoriteIceCream["Charlotte", default: "Unknown"]

// To create an empty collection (Array, Set, Dictionary) declare the var
// followed by empty parens
// Empty Dictionary:
var teams = [String: String]()
// alternative:
var teams2 = Dictionary<String, String>()

// empty array
var results = [Int]()
// alternative:
var results2 = Array<Int>()

// empty set
var words = Set<String>()
var numbers = Set<Int>()

// Enum or Enumeration
enum Result {
    case success
    case failure
}

let result4 = Result.failure

// can store associated values in an enum
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

// allows for more precision in enum
let talking = Activity.talking(topic: "Football")

// Enum raw values
// each case is assigned a raw value, beginning with 0
enum Planet: Int {
    case mercury = 1 // default is 0 if not specified
    case venus
    case earth
    case mars
}

// can access earth by its raw value
let earth = Planet(rawValue: 3)
