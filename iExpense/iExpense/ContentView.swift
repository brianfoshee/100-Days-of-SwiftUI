//
//  ContentView.swift
//  iExpense
//
//  Created by Brian Foshee on 23/4/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("tapCount") private var tapCount = 0

    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
