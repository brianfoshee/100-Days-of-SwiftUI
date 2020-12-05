// https://www.hackingwithswift.com/100/swiftui/8
import UIKit

struct Sport {
    // stored properties
    var name: String
    var isOlympicSport: Bool

    // computed property
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}

var tennis = Sport(name: "Tennis", isOlympicSport: false)
print(tennis.name)
print(tennis.olympicStatus)

// vars, can be changed
tennis.name = "Lawn tennis"

struct Progress {
    var task: String

    var amount: Int {
        // property observer
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100

struct City {
    var population: Int

    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
london.collectTaxes()

// swift doesn't let you change property values from inside a struct unless explictly defined
struct Person {
    var name: String

    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
person.makeAnonymous()

// cannot do this because instance is a constant
//let p = Person(name: "Brian")
//p.makeAnonymous()

// string methods
let string = "Do or do not, there is no try."

print(string.count)
print(string.hasPrefix("Do"))
print(string.uppercased())
print(string.sorted())

// array methods
var toys = ["Woody"]
print(toys.count)
toys.append("Buzz")
toys.firstIndex(of: "Buzz")
print(toys.sorted())
toys.remove(at: 0)
