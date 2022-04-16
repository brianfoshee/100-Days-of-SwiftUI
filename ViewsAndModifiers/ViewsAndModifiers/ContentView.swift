//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Brian Foshee on 16/4/22.
//

import SwiftUI

struct ContentView: View {
    @State private var useRed = true

    var body: some View {
        VStack {
            Text("Gryffindor")
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
        }
        // this applies to all text views because vstack is a container
        .font(.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
