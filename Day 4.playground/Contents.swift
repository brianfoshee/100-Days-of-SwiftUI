// https://www.hackingwithswift.com/sixty/4/1/for-loops
import UIKit

// a range of numbers
let count = 1...10

// use the range in a for loop
for number in count {
    print("Number is \(number)")
}

// works for arrays too
let albums = ["Red", "1989", "Reputation"]
for album in albums {
    print("\(album) is on Apple Music")
}

// use _ if you don't need the value
print("Players gonna")
for _ in 1...5 {
    print("play")
}

// while loops
var number = 1
while number <= 20 {
    print(number)
    number += 1
}
print("Ready or not, here I come")

// repeat
number = 1
repeat {
    print(number)
    number += 1
} while number <= 20

print("ready or not, here I come")

// breaking from a loop
var countDown = 10
while countDown >= 0 {
    print(countDown)
    if countDown == 4 {
        print("I'm bored. Let's go now")
        break
    }
    countDown -= 1
}
print("Blast Off")

// breaking out of an outer loop
outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print("\(i) * \(j) is \(product)")

        if product == 50 {
            break outerLoop
        }
    }
}

// skip the current item
for i in 1...10 {
    if i % 2 == 1 {
        continue
    }

    print(i)
}
