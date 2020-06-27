//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by Brian Foshee on 7/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

/*
 Each turn of the game the app will randomly pick either rock, paper, or scissors.
 Each turn the app will either prompt the player to win or lose.
 The player must then tap the correct move to win or lose the game.
 If they are correct they score a point; otherwise they lose a point.
 The game ends after 10 questions, at which point their score is shown.
 */

import SwiftUI

struct ContentView: View {
    @State private var score: Int = 0
    @State private var showingGameOver: Bool = false
    @State private var move: Int = Int.random(in: 0 ..< 3)

    // outcomes stores whether the outcome of the game should be win/true or lose/false
    @State private var outcome: Bool = Bool.random()

    private var moveCount: Int = 0
    private var moves: [String] = ["Rock", "Paper", "Scissors"]

    // wins is a dictionary storing a move and the move that beats it
    // 0:1 means that 1/Paper beats 0/Rock
    var wins: [Int:Int] = [0:1, 1:2, 2:0]

    var body: some View {
        VStack(spacing: 50) {
            VStack(alignment: .leading) {
                Text("Score: \(score)")
                Text("Move: \(moves[move])")
                Text("Outcome: \(outcome ? "win" : "lose")")
            }

            HStack {
                Text("Pick your move:")

                ForEach(0 ..< moves.count) { i in
                    Button(action: {
                        self.buttonTapped(i)
                    }) {
                        Text("\(self.moves[i])")
                    }
                }
            }
        }
        .alert(isPresented: $showingGameOver) {
            Alert(title: Text("Game Over"),
                  message: Text("Your score is \(score.description) / 10"),
                  dismissButton: .default(Text("Continue")) {
                    self.resetGame()
                })
        }
    }

    func buttonTapped(_ index: Int) {
        // should win || should lose
        if (outcome == true && index == wins[move]) ||
            (outcome == false && index != wins[move]) {
            correctMove()
        } else {
            incorrectMove()
        }

        moveCount = moveCount + 1
        if moveCount == 10 {
            showingGameOver = true
        }
    }

    func correctMove() {
        score = score + 1
        move = Int.random(in: 0 ..< 3)
        outcome = Bool.random()
    }

    func incorrectMove() {
        move = Int.random(in: 0 ..< 3)
        outcome = Bool.random()
    }

    func resetGame() {
        score = 0
        moveCount = 0
        move = Int.random(in: 0 ..< 3)
        outcome = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
