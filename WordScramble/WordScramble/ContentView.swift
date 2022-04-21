//
//  ContentView.swift
//  WordScramble
//
//  Created by Brian Foshee on 19/4/22.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    @State private var score = 0

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }

                Section("Score") {
                    Text("\(score)")
                }

                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .toolbar {
                Button("New Game", action: startGame)
            }
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // exit if the string is empty
        guard answer.count >= 3 else {
            wordError(title: "word not long enough", message: "Should be at least 3 characters")
            return
        }

        guard isNotRoot(word: answer) else {
            wordError(title: "word cannot be start word", message: "Nice try")
            return
        }

        guard isOriginal(word: answer) else {
            wordError(title: "word already used", message: "be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "word not possible", message: "You can't spell that word from \(rootWord)")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "word not recognized", message: "you can't just make them up, you know")
            return
        }

        // add to score
        score += 1

        withAnimation {
            // insert word into array at first position so it shows at top of list
            usedWords.insert(answer, at: 0)
        }

        // reset word entry
        newWord = ""
    }

    func isNotRoot(word: String) -> Bool {
        word != rootWord
    }

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    /*
     we can then loop over each letter of the user’s input word to see if that letter exists in our copy.
     If it does, we remove it from the copy (so it can’t be used twice), then continue.
     If we make it to the end of the user’s word successfully then the word is good,
        otherwise there’s a mistake and we return false.
     */
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }

    /*
     make an instance of UITextChecker, which is responsible for scanning strings for misspelled words.
     */
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }

    func startGame() {
        usedWords.removeAll()
        score = 0

        // 1. get the url of the start.txt file in the bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. split into an array, on line breaks
                let allWords = startWords.components(separatedBy: "\n")

                // 4. pick one random word
                rootWord = allWords.randomElement() ?? "silkworm"

                // everything worked
                return
            }
        }
        // crash if it didn't work
        fatalError("could not load start.txt from bundle")
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
