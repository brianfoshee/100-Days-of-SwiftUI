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

struct ContentView: View {
    @State private var showingConfig: Bool = true
    @State private var tableSelection: Int = 1
    @State private var questionsSelection: Int = 0

    var questionAmount: [Int] = [5, 10, 20, 24]
    var multiplicationTable: [[Int]:Int] {
        // generate the full multiplication table, 24 combinations
        // If table is 5, the dictionary looks like:
        // [5, 1]: 5, [1, 5]: 5, [5, 2]: 10, [2, 5]: 10 etc
        var fullTable: [[Int]:Int] = [[Int]:Int]()
        for i in 1...12 {
            fullTable[[i, tableSelection]] = i * tableSelection
            fullTable[[tableSelection, i]] = i * tableSelection
        }

        if questionsSelection == 3 {
            return fullTable
        }

        // Select a random assortment of questions
        var output: [[Int]:Int] = [[Int]:Int]()
        for _ in 0..<questionAmount[questionsSelection] {
            if let e = fullTable.randomElement() {
                output[e.key] = e.value
            }
        }
        return output
    }

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
                    }
                )
            } else {
                HStack{
                    Text("doing \(tableSelection) multiplication tables")
                }
                .navigationBarTitle("Multiplication Tables")
                .navigationBarItems(leading: Button("Config"){
                    self.showingConfig = true
                    }, trailing: Button("Start Over") {
                        // TODO start over
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
