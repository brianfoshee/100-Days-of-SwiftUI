// https://www.hackingwithswift.com/100/swiftui/10
import UIKit

// always have to create your own initializer for classes

class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }

    func makeNoise() {
        print("Woof")
    }
}

let poppy = Dog(name: "Poppy", breed: "Poodle")
poppy.makeNoise()

// class Poodle inherits Dog; it's a subclass of Dog
class Poodle: Dog {
    // can have its own initizlier
    init(name: String) {
        // MUST call super.init inside though
        super.init(name: name, breed: "Poodle")
    }

    override func makeNoise() {
        print("yip")
    }
}

let poppy1 = Poodle(name: "Poppy")
poppy1.makeNoise()

// final means no subclasses are allowed
final class Fish {
    var name: String
    var species: String

    init(name: String, species: String) {
        self.name = name
        self.species = species
    }
}

class Singer {
    var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name)

var singerCopy = singer
singerCopy.name = "J Biebs"

// singerCopy points to the same instance as singer
// if Singer was a struct, it'd be a copy
print(singer.name)

class Person {
    var name = "John Doe"

    init() {
        print("\(name) is alive")
    }

    // only classes can have deinitizliers
    // cannot take any params; never called by code direclty
    deinit {
        print("\(name) is no more")
    }

    func printGreeting() {
        print("Hello, I'm \(name)")
    }
}

for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}

class Singer1 {
    var name = "Taylor Swift"
}

let taylor = Singer()
// even though taylor is a constant (let), the param is a var which is mutable
// this is not the same as structs
taylor.name = "Ed Sheeran"
print(taylor.name)

class Singer2 {
    // let will not allow instances to change the name
    let name = "Taylor Swift"
}
