//
//  DisabledView.swift
//  CupcakeCorner
//
//  Created by Brian Foshee on 1/5/22.
//

import SwiftUI

struct DisabledView: View {
    @State private var username = ""
    @State private var email = ""

    var disableForm: Bool {
        username.isEmpty || email.isEmpty
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create Account") {
                    print("creating account...")
                }
            }
            // don't allow submit while these are empty
            .disabled(disableForm)
        }
    }
}

struct DisabledView_Previews: PreviewProvider {
    static var previews: some View {
        DisabledView()
    }
}
