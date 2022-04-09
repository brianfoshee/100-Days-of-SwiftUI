// https://www.hackingwithswift.com/100/swiftui/9
import Cocoa
import Foundation

// closures

let sayHello = {
    print("Hi there!")
}
sayHello()

// closures start and end with braces, so params and code has to be inside
// 'in' is used to mark the end of the params and return type
let sayHelloA = { (name: String) -> String in
    "Hi \(name)!"
}
sayHelloA("brian")

let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let sortedTeam = team.sorted()
print(sortedTeam)
// sorted can accept a closure with rules about how to sort
// the closure has a type (String, String) -> Bool
func captainFirstSorted(name1: String, name2: String) -> Bool {
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
}

let captainFirstTeam = team.sorted(by: captainFirstSorted)
print(captainFirstTeam)

// can pass the closure directly with closure syntax {}
let captainFirstTeamA = team.sorted(by: { (name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
})
print(captainFirstTeamA)

// closures cannot accept external param names
// and they cannot be called with param names

// since closure types are defined there's no need to declare the signature
// no need for String or a return Bool
let captainFirstTeamB = team.sorted(by: { name1, name2 -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
})

// trailing closure syntax - no need for the parens
let captainFirstTeamC = team.sorted { name1, name2 in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
}

// shorthand syntax for param names
// name1 becomes $0 name2 becomes $1
// don't need 'in'
let captainFirstTeamD = team.sorted {
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    }

    return $0 < $1
}

// more closure examples
// don't need explicit return if only one line
let tOnly = team.filter { $0.hasPrefix("T")}
print(tOnly)

let uppercaseTeam = team.map { $0.uppercased() }
print(uppercaseTeam)

// passing funcs as params
func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()

    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }

    return numbers
}

// pass as trailing closure
let rolls = makeArray(size: 50) {
    Int.random(in: 1...20)
}

func generateNumber() -> Int {
    Int.random(in: 1...20)
}

let newRolls = makeArray(size: 10, using: generateNumber)
print(newRolls)

// challenge
/*
 You’ve already met sorted(), filter(), map(), so I’d like you to put them together in a chain – call one, then the other, then the other back to back without using temporary variables.
 */
let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

/*
 Your job is to:

 Filter out any numbers that are even
 Sort the array in ascending order
 Map them to strings in the format “7 is a lucky number”
 Print the resulting array, one item per line
 So, your output should be as follows:

 7 is a lucky number
 15 is a lucky number
 21 is a lucky number
 31 is a lucky number
 33 is a lucky number
 49 is a lucky number
 */

luckyNumbers.filter {
    // $0 % 2 != 0
    !$0.isMultiple(of: 2)
}.sorted {
    $0 < $1
}.map {
    "\($0) is a lucky number"
}.forEach {
    print($0)
}

