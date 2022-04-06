// https://www.hackingwithswift.com/100/swiftui/4
import Cocoa

// type annotations

// implicit types
let surname = "Lasso"
var score = 0

// explicit types
let surnamee: String = "Lasso"
let scoree: Int = 0
let scorede: Double = 0

// bool
var isAuthed: Bool = true

// array
var albums: [String] = ["Red", "Fearless"]

// dict
var user: [String: String] = ["id": "@twostraws"]

// set
var books: Set<String> = Set(["good book"])

// type annotation to create empty array
var cities: [String] = []
// or type inference
var clues = [String]()

// create a constant and then set it once
let username: String
// allowed to do this once by the compiler
username = "brian"

// This time the challenge is to create an array of strings, then write some code that prints the number of items in the array and also the number of unique items in the array.

let foods = ["couscous", "fish", "thai", "fish"]
let foodSet = Set(foods) // or Set<String>(foods)

print("There are \(foods.count) items in the foods array and \(foodSet.count) unique items.")
