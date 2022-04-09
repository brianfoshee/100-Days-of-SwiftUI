// https://www.hackingwithswift.com/100/swiftui/11
import Cocoa

// access control

struct BankAccount {
    private(set) var funds = 0

    mutating func deposit(amount: Int) {
        funds += amount
    }

    mutating func withdraw(amount: Int) -> Bool {
        if funds > amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

// without access control on the funds property it can be modified by anyone
// doing account.funds += 1000
// adding private in front of the declaration only allows that var to be modified
// by struct-internal methods

/*
 Use private for “don’t let anything outside the struct use this.”
 Use fileprivate for “don’t let anything outside the current file use this.”
 Use public for “let anyone, anywhere use this.”
 private(set). This means “let anyone read this property, but only let my methods write it.”
 */

// static properties
struct School {
    static var studentCount = 0

    // no need to add mutating here since it's static
    static func add(student: String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}

// static properties are on the struct
School.add(student: "Taylor Swift")
print(School.studentCount)

/*
 To access non-static code from static code… you’re out of luck: static properties and methods can’t refer to non-static properties and methods because it just doesn’t make sense – which instance of School would you be referring to?
 To access static code from non-static code, always use your type’s name such as School.studentCount. You can also use Self to refer to the current type.
 */

/*
 Now we have self and Self, and they mean different things: self refers to the current value of the struct, and Self refers to the current type.
 */

// can use static properties to create examples of a struct
// this is useful during tests, design previews, swiftui previews, etc
struct Employee {
    let username: String
    let password: String

    static let example = Employee(username: "cfederighi", password: "hairforceone")
}

/*
 To check your knowledge, here’s a small task for you: create a struct to store information about a car, including its model, number of seats, and current gear, then add a method to change gears up or down. Have a think about variables and access control: what data should be a variable rather than a constant, and what data should be exposed publicly? Should the gear-changing method validate its input somehow?
 */
enum ShiftError: Error {
    case invalidGear
}

struct Car {
    let model: String
    let seats: Int
    // how many gears the car has
    // not allowed to set externally
    private(set) var gears: Int
    // private because only the car should be able to change gears
    // start at one
    private(set) var gear: Int = 1

    mutating func shift(to gear: Int) throws {
        if gear > gears || gear < 1 {
            throw ShiftError.invalidGear
        }
        self.gear = gear
    }

    init(model: String, seats: Int, gears: Int) {
        self.model = model
        self.seats = seats
        self.gears = gears
    }
}

var sprinter = Car(model: "Mercedes Sprinter", seats: 2, gears: 6)
print(sprinter.gear)
sprinter.shift(to: 2)
print(sprinter.gear)
sprinter.shift(to: 1)
print(sprinter.gear)
