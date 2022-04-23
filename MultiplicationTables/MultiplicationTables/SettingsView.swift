//
//  SettingsView.swift
//  MultiplicationTables
//
//  Created by Brian Foshee on 23/4/22.
//

import SwiftUI

struct SettingsView: View {
    var startGame: (_ multiplicationTable: Int, _ questionAmount: Int) -> ()
    @State private var questionAmount = 5
    let questionAmountOptions = [5, 10, 20]

    @State private var multiplicationTable = 2
    let multiplicationTables = 2..<13


    var body: some View {
        Form {
            Section("Which multiplication table?") {
                Picker("Which multiplication table?", selection: $multiplicationTable) {
                    ForEach(multiplicationTables, id: \.self) { i in
                        Text("\(i)")
                    }
                }
                .pickerStyle(.wheel)
            }

            Section("How many questions?") {
                Picker("How many question", selection: $questionAmount) {
                    ForEach(questionAmountOptions, id: \.self) { i in
                        Text("\(i)")
                    }
                }
                .pickerStyle(.segmented)
            }

            Button("Start Game") {
                startGame(multiplicationTable, questionAmount)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView {
            print($0, $1)
        }
    }
}
