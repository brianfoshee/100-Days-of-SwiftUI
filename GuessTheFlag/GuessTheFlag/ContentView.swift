//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Brian Foshee on 13/4/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("First")
                Text("second")
                Text("third")
            }
            Spacer()
            HStack {
                Text("First")
                Text("second")
                Text("third")
            }
            Spacer()
            HStack {
                Text("First")
                Text("second")
                Text("third")
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
