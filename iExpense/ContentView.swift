//
//  ContentView.swift
//  iExpense
//
//  Created by Brian Foshee on 13/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount: Int = UserDefaults.standard.integer(forKey: "Tap")

    var body: some View {
        Button("tap count: \(tapCount)") {
            self.tapCount += 1
            UserDefaults.standard.set(self.tapCount, forKey: "Tap")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
