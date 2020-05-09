//
//  ContentView.swift
//  Animations
//
//  Created by Brian Foshee on 9/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    var body: some View {
        print(animationAmount)

        return VStack {
            Button("Tap me") {
                // self.animationAmount += 1
            }
            .padding(50)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
                // .scaleEffect(animationAmount)
                //.animation(.interpolatingSpring(stiffness: 50, damping: 1))
                //.animation(.easeInOut(duration: 2))
                //.blur(radius: (animationAmount - 1) * 3)
                .overlay(
                    Circle()
                        .stroke(Color.red)
                        .scaleEffect(animationAmount)
                        .opacity(Double(2 - animationAmount))
                        .animation(
                            Animation.easeInOut(duration: 2)
                                .repeatForever(autoreverses: true)
                    )
            )
                .onAppear {
                    self.animationAmount = 2
            }

            Stepper("Scale amount", value: $animationAmount.animation(
                Animation.easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1...10)

            VStack {
                Stepper("Scale amount",
                        value: $animationAmount.animation(),
                        in: 1...10)

                Spacer()

                Button("Tap me") {
                    self.animationAmount += 1
                }
                .padding(40)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .scaleEffect(animationAmount)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
