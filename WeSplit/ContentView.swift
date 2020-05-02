//
//  ContentView.swift
//  WeSplit
//
//  Created by Brian Foshee on 2/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let students: [String] = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent: Int = 0

    var body: some View {
        VStack {
            Picker("Select your student", selection: $selectedStudent) {
                ForEach(0 ..< students.count) { i in
                    Text(self.students[i])
                }
            }
            Text("You chose: Student # \(students[selectedStudent])")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
