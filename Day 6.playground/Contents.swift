// https://www.hackingwithswift.com/100/swiftui/6
import UIKit

// closures

// this is a closure assigned to a variable
let driving = {
    print("I'm driving my car")
}
driving()

// To make a closure accept parameters, list them inside parentheses just after the opening brace, then write in so that Swift knows the main body of the closure is starting.
let driving2 = { (place: String) in
    print("I'm going to \(place)")
}
driving2("London")

// returning values from closure
let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}
let message = drivingWithReturn("NYC")
print(message)

// param of type "() -> Void". That means “accepts no parameters, and returns Void”
func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action() // call the closure
    print("I arrived")
}
// pass the closure from above
travel(action: driving)


// If the last parameter to a function is a closure, Swift lets you use special syntax called trailing closure syntax. Rather than pass in your closure as a parameter, you pass it directly after the function inside braces.
// because the last param in travel() is a closure, it can be called using
// trailing closure syntax
travel() {
    print("I'm driving in my car to FL")
}
// since there aren't any other params, parens can be eliminated
travel {
    print("I'm driving in my car to St Pete")
}
