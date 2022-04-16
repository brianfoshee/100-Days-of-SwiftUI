//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Brian Foshee on 16/4/22.
//

import SwiftUI

struct ContentView: View {
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")

    var body: some View {
        VStack {
            motto1
            motto2
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
