import Cocoa

var username = "Taylor Swift"

if username == "" {

}

// count requires swift to go through each letter one by one.
if username.count == 0 {

}

if username.isEmpty{

} else if username == "brian" {

} else {

}

// switch

enum Weather {
    case sun, rain, wind, snow, unknown
}

let forecast = Weather.sun

// switch needs a case for every possible option
// use fallthrough if you don't want the switch statement to return after its first match
switch forecast {
case .sun:
    print("it should be nice")
default:
    print("meh")
}

// ternary
// meh
let hour = 23
print(hour < 12 ? "It's before noon": "It's after noon")

let time = hour < 12 ? "Morning" : "Afternoon"
print(time)
