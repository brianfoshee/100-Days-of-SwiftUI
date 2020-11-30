import UIKit

// var is a variable that can be changed later
var str = "Hello, playground"

str = "Goodbye"

// Int type
var age = 38

var population = 8_000_000

var str1 = """
This goes
over multiple
lines and has
line breaks included
except for the opening
and closing breaks
"""

var str2 = """
This goes \
over multiple \
lines \
and does not include \
line breaks because of \
the slash chars
"""

// This is created as a Double type
var pi = 3.141

// boolean type
var awesome = true

var score = 85
// interpolate score into a string
var scoreStr = "Your score was \(score)"

// use let to create a constant; a variable that cannot have its value changed
let taylor = "swift"

// the type of newstr is interred as a String using type inference
let newstr = "Hello"

// if you need to specify the type of a variable you can
let album: String = "Reputation"
let year: Int = 1989
let height: Double = 1.78
let taylorRocks: Bool = true
