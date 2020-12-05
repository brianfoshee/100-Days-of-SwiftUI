// https://www.hackingwithswift.com/100/swiftui/9
import UIKit

struct User {
    var username: String

    // no func keyword before initializer
    // MUST provide a value for all properties before returning
    init() {
        username = "Anonymous"
        print("Creating a new user")
    }
}

// memberwise initializer, if no init() func
// var user = User(username: "twostraws")

var user1 = User()
user1.username = "twostraws"

struct Person {
    var name: String
    // lazy doesn't instantiate the var until it's accessed
    lazy var familyTree = FamilyTree()

    init(name: String) {
        print("\(name) was born")
        // self refers to the instance of the struct
        self.name = name
    }
}

struct FamilyTree {
    init() {
        print("Creating family tree")
    }
}

var ed = Person(name: "Ed")
ed.familyTree // initializes the property at this point, since it's lazy

struct Student {
    // static vars are class-scoped vars
    static var classSize = 0
    var name: String

    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

let ed1 = Student(name: "Ed")
let taylor = Student(name: "Taylor")
print(Student.classSize)

struct Person1 {
    // only methods inside this struct can access private vars
    private var id: String

    init(id: String) {
        self.id = id
    }

    func identity() -> String {
        return "My social is \(id)"
    }
}

let b = Person1(id: "123")
print(b.identity())
