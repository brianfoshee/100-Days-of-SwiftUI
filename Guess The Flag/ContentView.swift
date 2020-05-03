//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Brian Foshee on 2/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert: Bool = false

    var body: some View {
        Button("show alert") {
            self.showingAlert = true
        }
            // the binding here will set showingAlert back to false when it's dismissed
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Hello"),
                message: Text("message of the alert"),
                dismissButton: .default(Text("ok"))
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
