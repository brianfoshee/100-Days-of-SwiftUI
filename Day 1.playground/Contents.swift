// https://www.hackingwithswift.com/100/swiftui/1
// this is a comment
import Cocoa
import Darwin

var greeting = "Hello, playground"

var name = "Ted"
name = "Rebecca"
name = "Keeley"

let character = "Daphne"
// let is a constant so cannot reassign
// character = "Eloise"
// character = "Francesca"

var playerName = "Roy"
print(playerName)

playerName = "Dani"
print(playerName)

playerName = "Sam"
print(playerName)

// swift prefers camelCase
let actor = "Denzel Washington"

let movie = """
this is
a multi line
string
"""

print(actor.count)

let nameLength = actor.count
print(nameLength)
print("hello friend".uppercased())

print(movie.hasPrefix("this is"))

print("image.jpg".hasSuffix(".jpg"))

// numeric types
// Int
let score = 10

let reallyBig = 100_000_000 // same as 100000000

let number = 120
print(number.isMultiple(of: 3))

// Double
let fnumber = 0.1 + 0.2
print(fnumber)

// cannot add Int to Double
let a = 1
let b = 2.0
//let c = a + b
// have to cast:
let c = a + Int(b)
// or
let cx = Double(a) + b

// can use a Double in place of CGFloat
