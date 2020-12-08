//
//  ContentView.swift
//  WeSplit
//
//  Created by Brian Foshee on 7/12/20.
//
// https://www.hackingwithswift.com/100/swiftui/16

import SwiftUI

struct ContentView: View {
    @State private var tapCount: Int = 0
    @State private var name: String = "Brian"

    // doesn't need @State because it's only being read
    let students: [String] = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = 0

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Hello, world!")
                        .padding()
                }

                Button("Tap Count: \(tapCount)") {
                    self.tapCount += 1
                }

                Section {
                    // $ makes it a two-way binding; actions can write to the var in addition to reading
                    TextField("Enter Your Name", text: $name)
                    // don't need a two-way binding here. So no $
                    Text("Hello, \(name)")
                }

                Section {
                    VStack {
                        // $ because the Picker needs to modify the var
                        Picker("select your student:", selection: $selectedStudent) {
                            ForEach(0 ..< students.count) { i in
                                Text(self.students[i])
                            }
                        }
                        Text("You chose student: \(students[selectedStudent])")
                    }
                }

                // ForEach is not limited to the 10 views max
                ForEach(0..<100) { number in
                    Text("\(number)")
                }
            }
//            .navigationBarTitle(Text("Swift UI"), displayMode: .inline)
            .navigationBarTitle("SwiftUI")

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
