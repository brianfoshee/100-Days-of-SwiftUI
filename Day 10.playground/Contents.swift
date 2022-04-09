// https://www.hackingwithswift.com/100/swiftui/10
import Cocoa

// structs
struct Album {
    let title: String
    let artist: String
    let year: Int

    func printSummary() {
        print("\(title) (\(year)) by \(artist)")
    }
}

let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)
print(red.title)
red.printSummary()

struct Employee {
    // properties
    let name: String
    var vacationRemaining: Int

    // methods
    // since this func modifies a struct variable, it needs 'mutating'
    mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation!")
            print("Days remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining.")
        }
    }
}

// syntactic sugar on an init func that swift auto creates
var archer = Employee(name: "Sterling Archer", vacationRemaining: 14)
archer.takeVacation(days: 5)
print(archer.vacationRemaining)

// let is not allowed here because the struct is modified.
// let archer = Employee(name: "Sterling Archer", vacationRemaining: 14)


// computed properties
// structs can have two kinds of properties: a stored property (var or const) and a computed property (calculates the value every time it's accessed)
// NOTE: constants cannot have computed properties

/*
 could do something like:
 archer.takeVacation(days: 5)
 archer.takeVacation(days: 3)

 but we lose track of how many days were allocated originally.
 */

struct Employee2 {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0

    var vacationRemaining: Int {
        vacationAllocated - vacationTaken
    }
}

var archer2 = Employee2(name: "Sterling Archer", vacationAllocated: 14)
archer2.vacationTaken += 4
print(archer2.vacationRemaining)

// computed property getters and setters
// to set vacationRemaining, let's assume we want to increase or decrease vacationAllocated
struct Employee3 {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0

    var vacationRemaining: Int {
        get {
            vacationAllocated - vacationTaken
        }
        set {
            // newValue is automatically provided when setting
            vacationAllocated = vacationTaken + newValue
        }
    }
}

var archer3 = Employee3(name: "Sterling", vacationAllocated: 14)
archer3.vacationTaken += 4
print(archer3.vacationAllocated)
archer3.vacationRemaining = 5
print(archer3.vacationAllocated)

// when to use?
// https://www.hackingwithswift.com/quick-start/understanding-swift/when-should-you-use-a-computed-property-or-a-stored-property
/*
 if you regularly read the property when its value hasn’t changed, then using a stored property will be much faster than using a computed property. On the other hand, if your property is read very rarely and perhaps not at all, then using a computed property saves you from having to calculate its value and store it somewhere.

 When it comes to dependencies – whether your property’s value relies on the values of your other properties – then the tables are turned: this is a place where computed properties are useful, because you can be sure the value they return always takes into account the latest program state.
 */

// property observers
// a didSet observer to run when the property just changed, and a willSet observer to run before the property changed.
struct Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}
var game = Game()
game.score += 10
game.score -= 3
game.score += 1

// Swift automatically provides the constant oldValue inside didSet
// Swift automatically provides the constant newValue inside willSet
struct App {
    var contacts = [String]() {
        willSet {
            print("current value: \(contacts)")
            print("new value will be: \(newValue)")
        }

        didSet {
            print("there are now \(contacts.count) contacts")
            print("before there were \(oldValue.count) contacts")
        }
    }
}
var app = App()
app.contacts.append("Adrian")
app.contacts.append("Allen")
app.contacts.append("Ish")

// initializers
// you can also create your own as long as you follow one golden rule: all properties must have a value by the time the initializer ends.
// Important: Although you can call other methods of your struct inside your initializer, you can’t do so before assigning values to all your properties
// You can add multiple initializers to your structs if you want, as well as leveraging features such as external parameter names and default values
// However, as soon as you implement your own custom initializers you’ll lose access to Swift’s generated memberwise initializer unless you take extra steps to retain it

struct Player {
    let name: String
    let number: Int
}
// swift generates the initializer used here
let player = Player(name: "Megan", number: 15)

struct PlayerInit {
    let name: String
    let number: Int

    // no func keyword in initializers
    // no explicit return statement. they always return the type they belong to
    init(name: String, number: Int) {
        self.name = name
        self.number = number
    }
}

let player2 = Player(name: "megan", number: 15)
