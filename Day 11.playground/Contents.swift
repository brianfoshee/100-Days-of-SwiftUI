// https://www.hackingwithswift.com/100/swiftui/11
import UIKit

protocol Identifiable {
    var id: String { get set }
    func identify()
}

extension Identifiable {
    func identify() {
        print("My ID is \(id).")
    }
}

struct User: Identifiable {
    var id: String
}

func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}

let brian = User(id: "Brian")
brian.identify()

protocol Payable {
    func calculateWager() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

// new types can just conform to this instead of needing to list them all
protocol Employee: Payable, NeedsTraining, HasVacation { }

extension Int {
    func squared() -> Int {
        return self * self
    }
}

let number = 8
number.squared()

// no stored properties, but computed properties are allowed
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

// protocol extensions wowowow
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

extension Collection {
    func summarize() {
        print("There are \(count) of us:")

        for name in self {
            print(name)
        }
    }
}

pythons.summarize()
beatles.summarize()
