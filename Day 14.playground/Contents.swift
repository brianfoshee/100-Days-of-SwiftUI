// https://www.hackingwithswift.com/100/swiftui/14
import Cocoa

// optionals
let opposites = [
    "Mario": "Wario",
    "Luigi": "Waluigi"
]
// this returns a String? aka Optional String
let peachOpposite = opposites["Peach"]

// 'unwrapping' optionals
// 1. if let syntax. Combines a conditional with a constant that is set only
//    if the optional can be unwrapped (eg there's a value inside).
if let marioOpposite = opposites["Mario"] {
    print("mario's opposite is \(marioOpposite)")
} else {
    print("the optional was empty")
}

// if let works for anything that returns an optional on the right side
func square(number: Int) -> Int {
    number * number
}

var number: Int? = nil
// won't compile because number is an Optional Int, types don't match
// print(square(number: number))
// if let to check if the optional has a value in it
if let unwrappedNumber = number {
    print(square(number: unwrappedNumber))
}
//  it’s very common to unwrap them into a constant of the same name.
// aka shadowing
if let number = number {
    print(square(number: number))
}

// unwrapping with guard let (early returns, the opposite of if let)
/*
 If you use guard to check a function’s inputs are valid, Swift will always require you to use return if the check fails.
 If the check passes and the optional you’re unwrapping has a value inside, you can use it after the guard code finishes.
 */
func printSquare(of number: Int?) {
    guard let number = number else {
        print("missing input")
        return // required
    }
    // number is now available as an Int
    print("\(number) * \(number) is \(number * number)")
}

printSquare(of: number)

// you can use guard with any condition, including ones that don’t unwrap optionals. For example, you might use guard someArray.isEmpty else { return }.

// unwrapping options with nil coalescing
let captains = [
    "Enterprice": "Picard",
    "Voyager": "Janeway",
    "Defiant": "Sisko",
]

// nil coalescing allows to set a default value:
let new = captains["Serenity"] ?? "N/A"
print(new)

// optional chaining
let names = ["Arya", "Bran", "Robb", "Sansa"]
// randomElement() returns an Optional. The chaining operator '?' will try to u
// unwrap that options. If it can, it calls uppercased(). If not, the nil coalescing
// operator ?? sets a default value so chosen is a String (not Optional String).
// if optional chain was not able to unwrap, the return value is still an optional
// which is why nil coalescing is used.
let chosen = names.randomElement()?.uppercased() ?? "N/A"
print("next in line: \(chosen)")

// optional try, for testing errors
enum UserError: Error {
    case badID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

// try? is optional try. we don't have to handle the error with try / catch
// we just know that getUser either succeeded or failed
// it causes getUser to return an Optional String
if let user = try? getUser(id: 23) {
    print("user: \(user)")
}

// to combine with nil coalescing the try? needs to be wrapped in parens
let user = (try? getUser(id: 23)) ?? "Anon"
print(user)

/*
 You’ll find try? is mainly used in three places:

 In combination with guard let to exit the current function if the try? call returns nil.
 In combination with nil coalescing to attempt something or provide a default value on failure.
 When calling any throwing function without a return value, when you genuinely don’t care if it succeeded or not – maybe you’re writing to a log file or sending analytics to a server, for example.
 */

/*
 our challenge is this: write a function that accepts an optional array of integers, and returns one randomly. If the array is missing or empty, return a random number in the range 1 through 100.

 If that sounds easy, it’s because I haven’t explained the catch yet: I want you to write your function in a single line of code. No, that doesn’t mean you should just write lots of code then remove all the line breaks – you should be able to write this whole thing in one line of code.
 */

// as a full function
func rdm(from arry: [Int]?) -> Int {
    guard let arry = arry else {
        return Int.random(in: 1...100)
    }
    return arry.randomElement() ?? Int.random(in: 1...100)
}

var x: [Int]? = nil // the optional is nil case
var y = [Int]() // the empty array case
var z = [1, 2, 3] // the array has values case

print(rdm(from: x))
print(rdm(from: y))
print(rdm(from: z))

// in one line:
// arry?.randomElement() will use optional chaining to first check whether arry
// is not nil. If it is not nil, it calls randomElement(). If it is nil, nil
// coalescing happens and runs the Int.random code. Because of nil coalescing
// the return value is Int, not Optional Int.
// if arry?.randomElement() receives a non-nil but empty array, nil coalescing will
// again kick in and return a random Int (and not Optional Int).
// wicked.
func rdmol(from arry: [Int]?) -> Int { arry?.randomElement() ?? Int.random(in: 1...100) }
print(rdmol(from: x))
print(rdmol(from: y))
print(rdmol(from: z))
