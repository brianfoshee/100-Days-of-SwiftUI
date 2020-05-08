//
//  ContentView.swift
//  BetterRest
//
//  Created by Brian Foshee on 7/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp: Date = defaultWakeTime
    @State private var sleepAmount: Double = 8.0
    @State private var coffeeAmount: Int = 1

    private var idealBedTime: String {
        let model: SleepCalculator = SleepCalculator()
        let components: DateComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour: Int = (components.hour ?? 0) * 60 * 60
        let minute: Int = (components.minute ?? 0) * 60

        do {
            let prediction: SleepCalculatorOutput = try model.prediction(
                wake: Double(hour + minute),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount)
            )
            let sleepTime: Date = wakeUp - prediction.actualSleep
            let formatter: DateFormatter = DateFormatter()
            formatter.timeStyle = .short

            return formatter.string(from: sleepTime)
        } catch {
            print("Error calculating bed time")
        }
        return ""
    }

    static var defaultWakeTime: Date {
        var components: DateComponents = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Your ideal bed time is:")) {
                    Text("\(idealBedTime)")
                }

                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time",
                               selection: $wakeUp,
                               displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }

                Section(header: Text("Desired amount of sleep")) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }

                Section(header: Text("Daily coffee intake")) {
                    Picker("Daily Coffee Intake", selection: $coffeeAmount) {
                        ForEach(1 ..< 21) { i in
                            if i == 1 {
                                Text("1 cup")
                            } else {
                                Text("\(i) cups")
                            }
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(WheelPickerStyle())
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
