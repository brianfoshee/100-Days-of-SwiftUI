//
//  ContentView.swift
//  Moonshot
//
//  Created by Brian Foshee on 25/4/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(0..<100) {i in
                NavigationLink {
                    Text("stacks on stacks \(i)")
                } label: {
                    Text("hello \(i)")
                        .padding()
                }
            }
            .navigationTitle("swift")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
