//
//  ContentView.swift
//  Animations
//
//  Created by Brian Foshee on 20/4/22.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0

    var body: some View {
        Button("Tap Me") {
            // do nothing
            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .blur(radius: (animationAmount - 1) * 3)
        .scaleEffect(animationAmount)
        .animation(.default, value: animationAmount)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
