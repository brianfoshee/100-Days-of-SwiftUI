//
//  ContentView.swift
//  WordScramble
//
//  Created by Brian Foshee on 8/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords: [String] = [String]()
    @State private var rootWord: String = ""
    @State private var newWord: String = ""

    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    @State private var showingAlert: Bool = false

    @State private var score: Int = 0

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                List(usedWords, id: \.self) { i in
                    Image(systemName: "\(i.count).circle")
                    Text(i)
                }

                Text("Score: \(score)")
            }
        .navigationBarTitle(rootWord)
        .navigationBarItems(leading:
                Button("Restart", action: startGame)
        )
        }
        .onAppear(perform: startGame)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(errorTitle),
                  message: Text(errorMessage),
                  dismissButton: .default(Text("OK")))
        }
    }

    func addNewWord() {
        let answer: String = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        guard answer.count > 0 else {
            return
        }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word.")
            return
        }

        // calc score for word
        score += answer.count

        usedWords.insert(answer, at: 0)
        newWord = ""
    }

    func startGame() {
        // fine the URL for start.txt
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // load into string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // split into array, on newline
                let allWords = startWords.components(separatedBy: "\n")

                // pick a random word
                rootWord = allWords.randomElement() ?? "silkworm"

                return
            }
        }

        fatalError("Could not load start.txt from bundle")
    }

    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }

    func isPossible(word: String) -> Bool {
        var tempWord: String = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }

    func isReal(word: String) -> Bool {
        if word.count < 3 {
            return false
        }
        if word == rootWord {
            return false
        }
        let checker: UITextChecker = UITextChecker()
        let range: NSRange = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange: NSRange = checker.rangeOfMisspelledWord(in: word,
                                                            range: range,
                                                            startingAt: 0,
                                                            wrap: false,
                                                            language: "en")

        return misspelledRange.location == NSNotFound
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
