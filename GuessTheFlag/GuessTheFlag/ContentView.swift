//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Brian Foshee on 13/4/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingGameOver = false
    @State private var scoreTitle = ""
    @State private var gameOverMessage = ""
    @State private var score = 0
    @State private var questionsRemaining = 8
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    // show three flags, they each need a rotation amount to rotate independently
    @State private var rotationAmount = [0.0, 0.0, 0.0]
    // each button needs its own opacity
    @State private var opacityAmount = [1.0, 1.0, 1.0]

    // for accessibility
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()

            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.semibold))
                    .foregroundColor(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                            withAnimation {
                                rotationAmount[number] += 360
                                for i in 0...2 {
                                    if i != number {
                                        opacityAmount[i] = 0.25
                                    }
                                }
                            }
                            flagTapped(number)
                        } label: {
                            FlagImage(flag: countries[number])
                                .opacity(opacityAmount[number])
                                .rotation3DEffect(.degrees(rotationAmount[number]), axis: (x: 0, y: 1, z: 0))
                                .accessibilityLabel(labels[countries[number], default: "unknown flag"])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game Over!", isPresented: $showingGameOver) {
            Button("Play Again", action: askQuestion)
        } message: {
            Text(gameOverMessage)
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }

        questionsRemaining -= 1
        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacityAmount = [1.0, 1.0, 1.0]

        if questionsRemaining == 0 {
            questionsRemaining = 8
            gameOverMessage = "Game Over! You answered \(score) correct out of 8."
            showingGameOver = true
        }
    }
}

struct FlagImage: View {
    var flag: String
    var body: some View {
        Image(flag)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
