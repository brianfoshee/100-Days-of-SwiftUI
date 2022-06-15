//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Brian Foshee on 14/6/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink {
                Text("New Secondary")
            } label: {
                Text("Hello")
            }
            .navigationTitle("Primary")

            Text("Secondary")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
