//
//  ContentView.swift
//  Convert
//
//  Created by Brian Foshee on 2/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private let units: [UnitLength] = [
        UnitLength.feet,
        UnitLength.yards,
        UnitLength.miles,
        UnitLength.meters,
        UnitLength.kilometers,
    ]
    @State private var quantityFrom: String = ""
    @State private var unitFrom: Int = 0 // default is feed
    @State private var unitTo: Int = 3 // default is meters
    private var quantityTo: Double {
        let input: Double = Double(quantityFrom) ?? 0
        let from = Measurement(value: input, unit: self.units[unitFrom])
        let to = from.converted(to: self.units[unitTo])
        return to.value
    }

    var body: some View {
        NavigationView {
            Form {
                // TextField for quantity
                TextField("Input Amount", text: $quantityFrom)

                // Picker for unit from
                Section(header: Text("Unit to convert from")) {
                    Picker("Unit From", selection: $unitFrom) {
                        ForEach(0 ..< self.units.count) { i in
                            Text("\(self.units[i].symbol)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                // Picker for unit to
                Section(header: Text("Unit to convert to")) {
                    Picker("Unit To", selection: $unitTo) {
                        ForEach(0 ..< self.units.count) { i in
                            Text("\(self.units[i].symbol)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                // Text to show output
                Section(header: Text("Output Amount")) {
                    Text("\(quantityTo) \(self.units[unitTo].symbol)")
                }
            }
            .navigationBarTitle("Convert")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
