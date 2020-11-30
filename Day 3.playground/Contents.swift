// https://www.hackingwithswift.com/100/swiftui/3
import UIKit

let firstScore = 12
let secondScore = 4

// operators
let total = firstScore + secondScore
let difference = firstScore - secondScore

let product = firstScore * secondScore
let divident = firstScore / secondScore
let remainder = 13 % secondScore

// operator overloading

// plus also joins strings
let fakers = "Fakers gonna "
let action = fakers + "fake"

// or join arrays
let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf

// compound assignment operators
var score = 95
score -= 5

// similar with strings
var quote = "The in Spain falls mostly on the "
quote += "Spaniards"

// comparison operators return bool
firstScore == secondScore
firstScore != secondScore

firstScore < secondScore
firstScore >= secondScore

// also works on strings, alphabetically
"Taylor" <= "Swift"

// conditionals
let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 21 {
    print("Blackjack!")
} else if firstCard + secondCard == 2 {
    print("Aces - lucky!")
} else {
    print("Regular cards")
}

// combining conditionals
let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}

if age1 > 18 || age2 > 18 {
    print("at lesat 1 is over 18")
}

// ternary operator (blah)
print(firstCard == secondCard ? "Cards are the same" : "Cards are different")

// switch statements
let weather = "sunny"
switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("wrap up warm")
case "sunny":
    print("wear sunscreen")
    fallthrough // by default, a switch breaks after a case. fallthrough allows execution to continue to the next case.
default: // MUST have a case for every possible value
    print("enjoy your day!")
}

// range operators
// ... (closed range, includes values up to and including the final value)
// ..< (half open range, includes values up to but excluding the final value)
switch score {
case 0..<50:
    print("you failed badly")
case 50..<85:
    print("you did ok")
default:
    print("you did great")
}
