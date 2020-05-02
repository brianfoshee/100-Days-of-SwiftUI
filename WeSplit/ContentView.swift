//
//  ContentView.swift
//  WeSplit
//
//  Created by Brian Foshee on 2/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: String = ""
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Int = 2
    let tipPercentages: [Int] = [10, 15, 20, 25, 0]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) { i in
                            Text("\(i) people")
                        }
                    }
                }

                Section(header: Text("How much of a tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) { i in
                            Text("\(self.tipPercentages[i])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section {
                    Text("$\(checkAmount)")
                }
            }
                .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
