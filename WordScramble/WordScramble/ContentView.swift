//
//  ContentView.swift
//  WordScramble
//
//  Created by Brian Foshee on 19/4/22.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]

    var body: some View {
        VStack {
            // can create lists based on dynamic content, unlike forms
            List(4..<10) { i in
                Text("\(i)")
            }
            
            // works with the id param for array sources
            List(people, id: \.self) { name in
                Text("\(name)")
            }

            // or a mix of static and dynamic content
            List {
                Text("row a")

                ForEach(0..<5) { i in
                    Text("\(i)")
                }

                Section("hi") {
                    Text("inside")
                }
            }
            .listStyle(.grouped)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
