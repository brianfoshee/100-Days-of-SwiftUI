// https://www.hackingwithswift.com/100/swiftui/12
import UIKit

var age: Int? = nil

age = 38

var name: String? = nil

// name.count
// throws: error: value of optional type 'String?' must be unwrapped to refer to member 'count' of wrapped base type 'String'

if let unwrapped = name {
    print("\(unwrapped.count)")
} else {
    print("Missing name.")
}

func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name")
        return
    }
    // unwrapped is now available if it has a value
    print ("Hello, \(unwrapped)")
}

greet(nil)
greet("brian")

let str = "5"
let num = Int(str)
// num is an optional int
// can force unwrap beacause I know for sure it is an int
// if you're wrong, force unwrap will crash the app
let num1 = Int(str)!

// implicitly unwrapped optionals
// if you try to use without a value, code crashes
// ! means it's an implicitly-unwrapped optional int
let age1: Int! = nil

// nil coalescing
func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

// ?? is nil coalescing. Like the ternary operator.
let user = username(for: 15) ?? "Anonymous"

// optional chaining
let names = ["John", "Paul", "George", "Ringo"]
// if .first returns nil then the whole line evaluates to nil
// beatles is always an optional string because of the optional
let beatle = names.first?.uppercased()

// optional try
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

do {
    try checkPassword("password")
    print("That is good")
} catch {
    print("You can't use that")
}

// try? turns a throwing function into one that returns an optional
if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}

// try! can be used if you know for sure that the throwing function will not throw
// if it does, crash
try! checkPassword("secret")
print("OK")

// failable initializers
struct Person {
    var id: String

    // always returns Person?
    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

class Animal { }
class Fish: Animal { }
class Dog: Animal {
    func makeNoise() {
        print("Woof")
    }
}

// swift uses type inference to make pets an [Animal] (array of Animals)
let pets = [Fish(), Dog(), Fish(), Dog()]

// use as? to typecast check
for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}
