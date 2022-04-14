//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Brian Foshee on 13/4/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // https://www.hackingwithswift.com/books/ios-swiftui/buttons-and-images
        
        VStack {
            Button("Button 1", action: executeDelete)
                .buttonStyle(.bordered)

            Button("Button 2", role: .destructive, action: executeDelete)
                .buttonStyle(.bordered)

            Button("Button 3", action: executeDelete)
                .buttonStyle(.borderedProminent)
                .tint(.mint)

            Button("Button 4", role: .destructive, action: executeDelete)
                .buttonStyle(.borderedProminent)

            // custom button
            // This is particularly common when you want to incorporate images into your buttons.
            Button {
                print("Button was tapped")
            } label: {
                Text("Tap me!")
                    .padding()
                    .foregroundColor(.white)
                    .background(.red)
            }

            // just the image
            Button {
                print("Edit button was tapped")
            } label: {
                Image(systemName: "pencil")
            }

            // image plus label
            Button {
                print("tapped")
            } label: {
                Label("Edit", systemImage: "pencil")
            }
        }
    }

    func executeDelete() {
        print("deleting")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
