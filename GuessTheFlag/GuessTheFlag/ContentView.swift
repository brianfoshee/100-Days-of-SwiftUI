//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Brian Foshee on 13/4/22.
//

import SwiftUI

// https://www.hackingwithswift.com/books/ios-swiftui/showing-alert-messages
struct ContentView: View {
    @State private var showingAlert = false

    var body: some View {
        Button("show alert") {
            showingAlert = true
        }
        .alert("Important", isPresented: $showingAlert) {
            Button("delete", role: .destructive) {}
            Button("cancel", role: .cancel) {}
        } message: {
            Text("pls read v important")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
