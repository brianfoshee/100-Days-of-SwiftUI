// https://www.hackingwithswift.com/100/swiftui/2
import Cocoa

let goodDogs = true
var gameOver = false
// can assign bool from result
let isMultiple = 120.isMultiple(of: 3)

// toggle bools
print(gameOver)

gameOver.toggle()
print(gameOver)

let name = "Taylor"
let age = 26
let message = "Hello, my name is \(name) and I am \(age) years old."
print(message)

let number = 11
// not allowed: "Apollo" + number
let missionMessage = "Apollo" + String(number) + "landed on the moon"
// better: "Apollo \(number) landed on the moon"

// Checkpoint 1
// convert from celcius to fahrenheit
// 1. create a constant holding any temperature
// 2. converts it to fahrenheit by multiplying by 9, dividing by 5, adding 32
// 3 prints the result, showing both c and f

let celcius = 15
let fahrenheit = celcius * 9 / 5 + 32
print("\(celcius) degrees celcius is \(fahrenheit) degrees fahrenheit")
