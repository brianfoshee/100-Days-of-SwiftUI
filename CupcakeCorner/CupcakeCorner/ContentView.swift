//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Brian Foshee on 27/6/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    @State private var username = ""
    @State private var email = ""

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }
            .disabled(username.isEmpty || email.isEmpty)

        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
