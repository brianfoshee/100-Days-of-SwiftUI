//
//  ContentView.swift
//  WeSplit
//
//  Created by Brian Foshee on 11/4/22.
//

import SwiftUI

// View protocol has one requirement: a computed property called Body that
// returns `some View`
struct ContentView: View {
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"

    var body: some View {
        NavigationView {
            Form {
                Picker("Select your student", selection: $selectedStudent) {
                    ForEach(students, id: \.self) { name in
                        Text("\(name)")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
