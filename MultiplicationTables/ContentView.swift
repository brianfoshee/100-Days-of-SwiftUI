//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Brian Foshee on 10/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

/*
The player needs to select which multiplication tables they want to practice. This could be pressing buttons, or it could be an “Up to…” stepper, going from 1 to 12.
The player should be able to select how many questions they want to be asked: 5, 10, 20, or “All”.
You should randomly generate as many questions as they asked for, within the difficulty range they asked for. For the “all” case you should generate all possible combinations.
*/

import SwiftUI

struct Question {
    let x: Int
    let y: Int
    var answer: Int {
        return x * y
    }

    func isCorrect(guess num: Int) -> Bool {
        return answer == num
    }
}

struct ContentView: View {
    @State private var showingConfig: Bool = true
    @State private var tableSelection: Int = 4
    @State private var questionsSelection: Int = 0
    @State private var currentQuestionIndex: Int = 0
    @State private var guess: String = ""
    @State private var multiplicationTable: [Question] = [Question]()

    @State private var isShowingAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""

    var questionAmount: [Int] = [5, 10, 20, 24]

    var body: some View {
        NavigationView {
            if showingConfig {
                Form {
                    Section(header: Text("Which multiplication table would you like to practice?")) {
                        Stepper("\(tableSelection)", value: $tableSelection, in: 1...12)
                    }

                    Section(header: Text("How many questions would you like to answer?")) {
                        Picker("How Many Questions", selection: $questionsSelection) {
                            ForEach(0..<self.questionAmount.count) { i in
                                if self.questionAmount[i] == 24 {
                                    Text("All")
                                } else {
                                    Text("\(self.questionAmount[i])")
                                }
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                .navigationBarTitle("Multiplication Tables")
                .navigationBarItems(trailing:
                    Button("Play") {
                        self.showingConfig = false
                        // start game
                        self.generateTable()
                        self.currentQuestionIndex = 0
                    }
                )
            } else {
                Form {
                    Text("\(multiplicationTable[currentQuestionIndex].x) X \(multiplicationTable[currentQuestionIndex].y) = ")

                    TextField("answer:", text: $guess, onCommit: checkGuess)
                }
                .navigationBarTitle("\(tableSelection) Times Tables")
                .navigationBarItems(leading: Button("Config"){
                    self.showingConfig = true
                    }, trailing: Button("Start Over") {
                        // start over
                        self.generateTable()
                        self.currentQuestionIndex = 0
                })
                .alert(isPresented: $isShowingAlert) {
                    Alert(title: Text(alertTitle),
                          message: Text(alertMessage),
                          dismissButton: .default(Text("OK")){
                            self.guess = ""
                            if self.currentQuestionIndex == self.multiplicationTable.count - 1 {
                                // done, show score
                            } else {
                                self.currentQuestionIndex += 1
                            }
                        })
                }
            }
        }
    }

    func checkGuess() {
        let question: Question = multiplicationTable[currentQuestionIndex]
        if let guess = Int(guess) {
            let correct: Bool = question.isCorrect(guess: guess)
            if correct {
                // score plus 1
                alertTitle = "Correct!"
                alertMessage = ""
            } else {
                alertTitle = "Incorrect"
                alertMessage = "\(question.x) x \(question.y) = \(question.answer)"
            }
            isShowingAlert = true
        }
    }

    func generateTable() {
        // generate the full multiplication table, 24 combinations
        var fullTable: [Question] = [Question]()
        for i in 1...12 {
            fullTable.insert(Question(x: i, y: tableSelection), at: 0)
            fullTable.insert(Question(x: tableSelection, y: i), at: 0)
        }
        fullTable.shuffle()

        if questionsSelection == 3 {
            self.multiplicationTable = fullTable
        }

        // Select a random assortment of questions
        var output: [Question] = [Question]()
        for i in 0 ..< questionAmount[questionsSelection] {
            output.insert(fullTable[i], at: 0)
        }
        self.multiplicationTable = output
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
