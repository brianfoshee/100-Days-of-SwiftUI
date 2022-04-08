// https://www.hackingwithswift.com/100/swiftui/7
import Cocoa

// functions
func hello() {
    print("hello")
}

func printTimesTables(number: Int, end: Int) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(number: 5, end: 12)

// returning
func rollDice() -> Int {
    return Int.random(in: 1...6)
}

let result = rollDice()
print(result)

func doContainSameLetters(a: String, b: String) -> Bool {
    let sortedA = a.sorted()
    let sortedB = b.sorted()
    return sortedA == sortedB
}

print(doContainSameLetters(a: "abc", b: "bac"))

func areLettersIdentical(a: String, b: String) -> Bool {
    // don't even need a return statment if the function has only one line of code
    a.sorted() == b.sorted()
}

// tuples
func getUser() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
    // or
    // ("Taylor", "Swift")
}
print(getUser())
let user = getUser()
// the tuple values can be accessed with their key names
print("Name: \(user.firstName) \(user.lastName)")

// tuples don't need keys, they can be indexed from 0
func getUserNoKeys() -> (String, String) {
    ("Taylor", "Swift")
}
let u2 = getUserNoKeys()
print("Name: \(u2.0) \(u2.1)")

// can assign multiple at the same time
let (firstName, lastName) = getUser()
print("Name \(firstName) \(lastName)")
// can also use _ to discard a value
let (firstMeh, _) = getUser()
print(firstMeh)

// customizing function parameters
// 'string' here is the external param name when called, and for the internal param name inside the function
func isUppercase(string: String) -> Bool {
    string == string.uppercased()
}
print(isUppercase(string: "HI"))

// _ can be specified for the external param if you want to not have one
func isUppercaseU(_ string: String) -> Bool {
    string == string.uppercased()
}
print(isUppercaseU("HI"))

// can also specify an external param name
func isUppercaseA(word string: String) -> Bool {
    string == string.uppercased()
}
print(isUppercaseA(word: "HI"))
