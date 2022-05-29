//
//  EditCards.swift
//  FlashZilla
//
//  Created by Brian Foshee on 28/5/22.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""

    var body: some View {
        NavigationView {
            List {
                Section("Add New Card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add Card", action: addCard)
                }

                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear {
                cards = Card.loadCards()
            }
        }
    }

    func done() {
        dismiss()
    }


    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }

        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        Card.save(cards)

        newPrompt = ""
        newAnswer = ""
    }

    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        Card.save(cards)
    }
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
