//
//  AuthView.swift
//  BucketList
//
//  Created by Brian Foshee on 13/5/22.
//


import LocalAuthentication
import SwiftUI

struct AuthView: View {
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("locked")
            }
        }
        .onAppear(perform: authenticate)
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, go ahead and use
            let reason = "We need to unlock your app data"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    // auth success
                    isUnlocked = true
                } else {
                    // nope
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
