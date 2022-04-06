// https://www.hackingwithswift.com/100/swiftui/3
import Cocoa
import Darwin

// Arrays

var beatles = ["John", "Paul", "George"]
var numbers = [ 4, 8, 15]
var temps = [25.3, 28.2, 26.4]

print(beatles[0])
print(numbers[1])
print(temps[2])

// this crashes
// print(temps[10])

// if the array is variable it can be appended to
beatles.append("Adrian")

// array syntax (generics)
var scores = Array<Int>()
scores.append(100)

var albums = [String]()
albums.append("Red")

print(albums.count)

// remove two ways
var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count)

characters.remove(at: 2)
print(characters.count)

characters.removeAll()
print(characters.count)

characters = ["Lana", "Pam", "Ray", "Sterling"]

print(characters.contains("Pam"))

// returns a new array
print(characters.sorted())

print(characters.reversed())

// Dictionaries
let employee = [
    "name": "Taylor Swift",
    "job": "singer",
    "location": "LA",
]
// this prints an Optional String because it's not guaranteed to exist in the dictionary
print(employee["name"])

// better to set a default so it prints a String
print(employee["name", default: "Unknown"])

// create a dict using explicit syntax
var heights = [String: Int]()
heights["Yao Ming"] = 229

// Sets
// create an array and pass to the set. The set will remove any dupes, and won't remember order.
let people = Set(["Denzel", "Tom", "Nicolas", "Samual"])

// more explicit way
var p = Set<String>()
p.insert("Denzel")

// sorted returns an array
print(people.sorted())

// Enums
enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}
var day = Weekday.monday
print(day)
