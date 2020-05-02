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
    @State private var numberOfPeople: String = ""
    @State private var tipPercentage: Int = 2
    let tipPercentages: [Int] = [10, 15, 20, 25, 0]
    var total: Double {
        let tipSelection: Double = Double(tipPercentages[tipPercentage])
        let orderAmount: Double = Double(checkAmount) ?? 0
        let tipAmount: Double = orderAmount / 100 * tipSelection
        let grandTotal: Double = orderAmount + tipAmount
        return grandTotal
    }
    var totalPerPerson: Double {
        let peopleCount: Double = Double(numberOfPeople) ?? 2
        let amountPerPerson: Double = total / peopleCount
        return amountPerPerson
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Check Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)

                    TextField("Number of people", text: $numberOfPeople)
                }

                Section(header: Text("How much of a tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) { i in
                            Text("\(self.tipPercentages[i])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Total Amount")) {
                    Text("$\(total, specifier: "%.2f")")
                }

                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
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
