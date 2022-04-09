// https://www.hackingwithswift.com/100/swiftui/12
import Cocoa

// classes
// classes introduce inheritance vs structs
// SwiftUI uses structs extensively for its UI design
// it uses classes extensively for its data
/*
 https://www.hackingwithswift.com/quick-start/beginners/how-to-create-your-own-classes
 classes differ from structs in five key places:

 You can make one class build upon functionality in another class, gaining all its properties and methods as a starting point. If you want to selectively override some methods, you can do that too.
 Because of that first point, Swift won’t automatically generate a memberwise initializer for classes. This means you either need to write your own initializer, or assign default values to all your properties.
 When you copy an instance of a class, both copies share the same data – if you change one copy, the other one also changes.
 When the final copy of a class instance is destroyed, Swift can optionally run a special function called a deinitializer.
 Even if you make a class constant, you can still change its properties as long as they are variables.

 However, SwiftUI uses classes extensively, mainly for point 3: all copies of a class share the same data. This means many parts of your app can share the same information, so that if the user changed their name in one screen all the other screens would automatically update to reflect that change.
 */

class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()
newGame.score += 10

// inheritance
class Employee {
    let hours: Int

    init(hours: Int) {
        self.hours = hours
    }

    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}

class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours)")
    }
}

class Developer: Employee {
    func work() {
        print("coding for \(hours)")
    }

    // overriding the parent class's method
    override func printSummary() {
        print("I work \(hours) whenever I want.")
    }
}


let a = Developer(hours: 8)
let b = Manager(hours: 10)
a.work()
b.work()
a.printSummary()
b.printSummary()

// if a child class has any custom initializers, it must always call the parent’s initializer after it has finished setting up its own properties, if it has any.

class Vehicle {
    let isElectric: Bool

    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Car: Vehicle {
    let isConvertible: Bool

    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        // calls super.init last
        super.init(isElectric: isElectric)
    }
}

let teslaX = Car(isElectric: true, isConvertible: false)

// classes are reference types

class User {
    var username = "Anonymous"
}

var user1 = User()
var user2 = user1
// changes for both copies of the variable
user2.username = "Taylor"
print(user1.username)
print(user2.username)

// deinitializers

class UserA {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive")
    }

    // no func keyword, no parens, no params
    deinit {
        print("User \(id): I'm dead")
    }
}

for i in 1...3 {
    let user = UserA(id: i)
    print("User \(user.id): I'm in control!")
}

var users = [UserA]()
for i in 1...3 {
    let user = UserA(id: i)
    users.append(user)
}

print("loop done")
users.removeAll()
print("array cleared. users should be deinited")


/*
 Your challenge is this: make a class hierarchy for animals, starting with Animal at the top, then Dog and Cat as subclasses, then Corgi and Poodle as subclasses of Dog, and Persian and Lion as subclasses of Cat.

 But there’s more:

 The Animal class should have a legs integer property that tracks how many legs the animal has.
 The Dog class should have a speak() method that prints a generic dog barking string, but each of the subclasses should print something slightly different.
 The Cat class should have a matching speak() method, again with each subclass printing something different.
 The Cat class should have an isTame Boolean property, provided using an initializer.
 */

class Animal {
    let legs: Int

    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak() {
        print("i am doug")
    }
}

class Cat: Animal {
    let isTame: Bool

    init(legs: Int, isTame: Bool) {
        self.isTame = isTame
        super.init(legs: legs)
    }

    func speak() {
        print("boring cat noise")
    }
}

class Corgi: Dog {
    override func speak() {
        print("i have tiny legs")
    }
}

class Poodle: Dog {
    override func speak() {
        print("i give hugs")
    }
}

class Persian: Cat {
    override func speak() {
        print("boring persian cat")
    }
}

class Lion: Cat {
    override func speak() {
        print("rawr")
    }
}

var jojo = Poodle(legs: 4)
jojo.speak()
