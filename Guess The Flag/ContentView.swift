//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Brian Foshee on 2/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore: Bool = false
    @State private var scoreTitle: String = ""
    @State private var score: Int = 0
    @State private var animationAmount: Double = 0.0
    @State private var opacityAmount: Double = 1.0
    @State private var scaleAmount: Double = 1.0

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]),
                           startPoint: .top,
                           endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                }

                ForEach(0 ..< 3){ i in
                    Button(action: {
                        withAnimation {
                            self.flagTapped(i)
                        }
                    }) {
                        FlagImage(name: self.countries[i])
                    }
                    .opacity(i == self.correctAnswer ? 1.0 : self.opacityAmount)
                    .scaleEffect(CGFloat(i == self.correctAnswer ? 1.0 : self.scaleAmount))
                    .rotation3DEffect(
                        .degrees(i == self.correctAnswer ? self.animationAmount : 0),
                        axis: (x: 0, y: 1, z: 0))
                }

                Text("Score: \(score)")
                    .foregroundColor(.white)

                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message: Text("Your score is \(score)"),
                  dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            animationAmount += 360
            opacityAmount = 0.25
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            scaleAmount = 0.5
        }

        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacityAmount = 1
        scaleAmount = 1
    }
}

struct FlagImage: View {
    var name: String
    var body: some View {
        Image(self.name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
