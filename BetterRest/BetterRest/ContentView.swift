//
//  ContentView.swift
//  BetterRest
//
//  Created by Brian Foshee on 18/4/22.
//

import CoreML
import SwiftUI

struct ContentView: View {
    // this needs to be static so that wakeUp can use it at init time
    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }

    @State private var wakeUp = defaultWakeUpTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    // https://www.hackingwithswift.com/books/ios-swiftui/connecting-swiftui-to-core-ml
    var bedTime: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(
                wake: Double(hour + minute),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount)
            )

            // prediction will output seconds. need to subtract from desired wake up time.
            let sleepTime = wakeUp - prediction.actualSleep

            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return "Sorry, something went wrong with predicting your bed time."
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Wake Up Time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                }

                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }

                Section {
                    Picker("Daily Coffee Intake", selection: $coffeeAmount) {
                        ForEach(0..<20) { i in
                            Text(i == 1 ? "1 cup" : "\(i) cups")
                        }
                    }
                }

                Section("Your Ideal Bed Time") {
                    Text("\(bedTime)")
                        .font(.headline)
                }
            }
            .navigationTitle("BetterRest")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
