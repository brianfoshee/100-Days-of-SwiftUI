//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Brian Foshee on 16/4/22.
//

import SwiftUI

struct ContentView: View {
    @State private var appMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var showingScoreAlert = false
    @State private var scoreAlertText = ""
    @State private var questionsRemaining = 10
    @State private var score = 0

    var moves = ["🗿", "📄", "✂️"]

    var body: some View {
        VStack {
            Text("Score: \(score)")

            Text("App's move is \(moves[appMove])")

            Text("You should \(shouldWin ? "win" : "lose")")

            HStack {
                ForEach(moves, id: \.self) { move in
                    Button(move) { play(move) }
                }
            }
            .font(.system(size: 50))
        }
        .alert(scoreAlertText, isPresented: $showingScoreAlert) {
            Button("New Game", action: newGame)
        } message: {
            Text("Your score is \(score)")
        }
        // TODO another button for new game
    }

    // scissors beats paper
    // rock beats scissors
    // paper beats rock
    func play(_ move: String) {
        // wrap 2 back to 0
        let winningIndex = appMove == 2 ? 0 : (appMove + 1)
        let winningMove = moves[winningIndex]
        // wrap 0 back to 2
        let losingIndex = appMove == 0 ? 2 : (appMove - 1)
        let losingMove = moves[losingIndex]

        if shouldWin && move == winningMove || !shouldWin && move == losingMove {
            score += 1
        } else  {
            score -= 1
        }

        questionsRemaining -= 1
        if questionsRemaining == 0 {
            showingScoreAlert = true
            scoreAlertText = "Game Over!"
        } else {
            appMove = Int.random(in: 0...2)
            shouldWin.toggle()
        }
    }

    func newGame() {
        appMove = Int.random(in: 0...2)
        shouldWin.toggle()
        questionsRemaining = 10
        score = 0
    }
}

/*

 So, very roughly:

 Each turn of the game the app will randomly pick either rock, paper, or scissors.
 Each turn the app will alternate between prompting the player to win or lose.
 The player must then tap the correct move to win or lose the game.
 If they are correct they score a point; otherwise they lose a point.
 The game ends after 10 questions, at which point their score is shown.

 So, if the app chose “Rock” and “Win” the player would need to choose “Paper”, but if the app chose “Rock” and “Lose” the player would need to choose “Scissors”.
 */

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
