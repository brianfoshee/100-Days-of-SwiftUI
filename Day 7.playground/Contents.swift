// https://www.hackingwithswift.com/100/swiftui/7
import UIKit

func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

travel { (place: String) in
    print("I'm going to \(place) in my car")
}

func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

travel { (place: String) -> String in
    return ("I'm going to \(place) in my car.")
}

// swift knows that the param for place is a string,
// so it can be removed
travel { place -> String in
    return ("I'm going to \(place) in my car")
}

// swift also knows that the return is a string
travel { place in
    return "I'm going to \(place) in my car"
}

// since the closure only has one line, the return statement can be removed
travel { place in
    "I'm going to \(place) in my car"
}

// swift will provide automatic names for closure params (shorthand)
travel {
    "I'm going to \($0) in my car"
}

func travel(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("London", 60)
    print(description)
    print("I arrived!")
}

// called using trailing closure syntax and shorthand param names
travel {
    "I'm going to \($0) at \($1) miles per hour."
}

// returning closures
func travel() -> (String) -> Void {
    // counter is captured by the returning closure
    var counter = 1

    return { // closure with shorthand args
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}

let result = travel()
result("London") // or travel()("London")
result("London")
