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
        Button("hello") {
            useRed.toggle()
        }
        .foregroundColor(useRed ? .red : .blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
