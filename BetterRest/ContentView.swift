//
//  ContentView.swift
//  BetterRest
//
//  Created by Brian Foshee on 7/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeup: Date = Date()

    var body: some View {
        VStack {
            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                Text("\(sleepAmount, specifier: "%g") hours")
            }

            // looks weird with text on the left
            // two options:
            // 1) embed in a Form
            // 2) use hide labels
            DatePicker("Please enter a date", selection: $wakeup, in: Date()...)
                .labelsHidden()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
