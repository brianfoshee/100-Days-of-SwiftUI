// https://www.hackingwithswift.com/100/swiftui/8
import Cocoa

// default values in functions
func printTimesTables(for number: Int, end: Int = 12) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}
printTimesTables(for: 4, end: 10)
// don't have to pass 'end' because it has a default value
printTimesTables(for: 3)

// error handling
enum PasswordError: Error {
    case short, obvious
}

// if a function throws, it needs `throws`
// this doesn't mean is _has_ to throw. just that it can
func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }

    if password == "12345" {
        throw PasswordError.obvious
    }

    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}

// handling errors
// try! is used outside of a do block but will crash if the func throws
let password = "12345"
do {
    let result = try checkPassword(password)
    print("Password rating: \(result)")
    // can have multiple try calls
} catch PasswordError.short {
    print("use a longer password")
} catch PasswordError.obvious {
    print("too obvious")
} catch {
    print("there was an error.")
}
// error has error.localizedDescription

/*
 The challenge is this: write a function that accepts an integer from 1 through 10,000, and returns the integer square root of that number. That sounds easy, but there are some catches:

 You can’t use Swift’s built-in sqrt() function or similar – you need to find the square root yourself.
 If the number is less than 1 or greater than 10,000 you should throw an “out of bounds” error.
 You should only consider integer square roots – don’t worry about the square root of 3 being 1.732, for example.
 If you can’t find the square root, throw a “no root” error.
 */
enum NumberError: Error {
    case outOfBounds, noRoot
}
func mysqrt(of number: Int) throws -> Int {
    if number < 1 || number > 10000 {
        throw NumberError.outOfBounds
    }

    // loop to 100 because 100 is the sqrt of 10000, which is the largest input
    for i in 1...100 {
        let y = i * i
        if y == number {
            return i
        } else if y > number {
            break
        }
    }

    throw NumberError.noRoot
}

let n = 10000
do {
    let s = try mysqrt(of: n)
    print("sqrt of \(n) is \(s)")
} catch NumberError.noRoot {
    print("no square root for \(n)")
} catch NumberError.outOfBounds {
    print("\(n) is not between 1 and 10_000")
} catch {
    print("some other error")
}
