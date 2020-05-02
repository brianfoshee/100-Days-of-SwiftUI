//
//  ContentView.swift
//  WeSplit
//
//  Created by Brian Foshee on 2/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var name: String = ""

    var body: some View {
        Form {
            // $name binds the name variable so that changes are saved to the variable AND
            // the value can be read out of it into the text field.
            // This is a two-way binding.
            TextField("Enter your name", text: $name)

            // Don't need $name here because the variable is only being read, not written to
            Text("Your name is \(name)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
