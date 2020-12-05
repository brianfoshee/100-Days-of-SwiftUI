// https://www.hackingwithswift.com/100/swiftui/5
import UIKit

func printHelp() {
    let message = """
Welcome to Myapp!

Run this app inside a directory of images and
MyApp will resize them all into thumbnails
"""

    print(message)
}

printHelp()

// arguments
func square1(number: Int) {
    print(number * number)
}
square1(number: 8)

// returns
func square(number: Int) -> Int {
    return number * number
}
let result = square(number: 8)
print(result)

// param labels
// the param is called 'to name'
// externally it's called 'to', internally it's called 'name'
func sayHello(to name: String) {
    print("Hello, \(name)!")
}
sayHello(to: "Taylor")

// ignoring param labels, use an underscore
func greet(_ person: String) {
    print("Hello, \(person)!")
}
// no need to use param labels
greet("Taylor")

// default param values
// nicely is true by default if not specified
func greet2(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)")
    } else {
        print("Oh no, it's \(person)")
    }
}
greet2("Taylor")
greet2("Taylor", nicely: false)

// variadic params
// Int... turns into [Int] inside (array of int)
func square3(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}
square3(numbers: 1, 2, 3, 4, 5, 6)

// throwing functions

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
    print("That password is good")
} catch {
    print("You can't use that password")
}

// inout params
// all params are passed by value (constants)
// inout are passed by reference
func doubleInPlace(number: inout Int) {
    number *= 2
}
var myNum = 10
doubleInPlace(number: &myNum)
