//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Brian Foshee on 23/4/22.
//

/*
 The player needs to select which multiplication tables they want to practice. This could be pressing buttons, or it could be an “Up to…” stepper, going from 2 to 12.

 The player should be able to select how many questions they want to be asked: 5, 10, or 20.

 You should randomly generate as many questions as they asked for, within the difficulty range they asked for.

 Show the player how many questions they got correct at the end of the game, then offer to let them play again.
 */

import SwiftUI

struct Question: Hashable {
    let base: Int
    let multiplicand: Int
    var answer: Int {
        get { base * multiplicand }
    }
}

struct ContentView: View {
    @State private var questions = [Question]()

    @State private var playingGame = false
    @State private var currentQuestion = Question(base: 4, multiplicand: 12)
    @State private var answers = 0 // how many questions have been asked
    @State private var correctAnswers = 0
    @State private var answer = 0

    // alert stuff
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    var body: some View {
        if playingGame { // show game UI
            NavigationView {
                VStack {
                    HStack {
                        Text("\(currentQuestion.base)")
                            .frame(width: 100, height: 100)
                            .background(.blue)
                            .font(.title)

                        Text("X")
                            .font(.title)

                        Text("\(currentQuestion.multiplicand)")
                            .frame(width: 100, height: 100)
                            .background(.blue)
                            .font(.title)
                    }

                    Text("=")
                        .font(.title)

                    ZStack {
                        Color.yellow

                        TextField(
                            "\(currentQuestion.base) multiplied by \(currentQuestion.multiplicand) equals what?",
                            value: $answer,
                            format: .number
                        )
                        .keyboardType(.decimalPad)
                        .border(.secondary)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    }
                    .frame(width: 100, height: 100)

                    Button("Submit") { checkAnswer() }
                }
                .toolbar {
                    Button("New Game") { playingGame = false }
                }
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("New Game") { playingGame = false }
            } message: {
                Text(alertMessage)
            }
        } else { // show settings UI
            SettingsView {
                startGame(multiplicationTable: $0, questionAmount: $1)
            }
        }
    }

    func generateQuestions(base: Int, amount: Int) {
        // clear the array first
        questions.removeAll()

        // generate this many questions
        for _ in 1...amount {
            let question = Question(base: base, multiplicand: Int.random(in: 1...12))
            questions.append(question)
        }
    }

    func startGame(multiplicationTable: Int, questionAmount: Int) {
        answers = 0
        answer = 0
        correctAnswers = 0
        generateQuestions(base: multiplicationTable, amount: questionAmount)
        currentQuestion = questions[0]
        playingGame = true
    }

    func checkAnswer() {
        answers += 1
        if answer == currentQuestion.answer {
            correctAnswers += 1
        }

        answer = 0

        if answers != questions.count {
            // set currentQuestion to the question
            currentQuestion = questions[answers]
        } else {
            // game over
            alertTitle = "Game Over"
            alertMessage = "You scored \(correctAnswers) out of \(questions.count)."
            showingAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
