//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Brian Foshee on 2/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            // if the button is only text
            Button("Push Here") {
                print("pushed")
            }

            // to add more views inside a button
            Button(action: {
                print("pushed")
            }) {
                Text("No push here")
            }

            Button(action: {
                print("pushed")
            }) {
                // using this form, the screen reader will read the image name
                // Image("pencil")

                // using this for the screen reader will not read it
                // Image(decorative: "pencil")

                // load from SF Symbols
                Image(systemName: "pencil")
            }

            Button(action: {
                print("pushed")
            }) {
                HStack(spacing: 20) {
                    Image(systemName: "pencil")
                    Text("Edit")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
