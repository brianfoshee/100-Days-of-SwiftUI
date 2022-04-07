// https://www.hackingwithswift.com/100/swiftui/6
import Cocoa

let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

for os in platforms {
    print("swift works great on \(os)")
}

// 1...12 is 1 to 12 inclusive
for i in 1...12 {
    print("5 x \(i) is \(5 * i)")
}

// 1..<5 is 1 to 4 (exluding the last number)
for i in 1..<5 {
    print("\(i)")
}

// if you don't want to use the loop var replace with _
for _ in 1...5 {
 print("hi")
}

// while

var countdown = 10
while countdown > 0 {
    print("\(countdown)")
    countdown -= 1
}

// random number generator
let id = Int.random(in: 1...1000)
let amount = Double.random(in: 0...1)

var roll = 0

while roll != 20 {
    roll = Int.random(in: 1...20)
    print("I rolled a \(roll)")
}

print("something about d and d")

// continue keeps looping
// break stops

// fizz buzz
for i in 1...100 {
    let three = i.isMultiple(of: 3)
    let five = i.isMultiple(of: 5)
    if three && five {
        print("Fizz Buzz")
    } else if three {
        print("Fizz")
    } else if five {
        print("Buzz")
    } else {
        print("\(i)")
    }
}
