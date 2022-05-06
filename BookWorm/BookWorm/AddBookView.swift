//
//  AddBookView.swift
//  BookWorm
//
//  Created by Brian Foshee on 5/5/22.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) { genre in
                            Text(genre)
                        }
                    }
                }

                Section {
                    TextEditor(text: $review)

                    Picker("Rating", selection: $rating) {
                        ForEach(0..<6) { i in
                            Text(String(i))
                        }
                    }
                } header: {
                    Text("Write a review")
                }

                Section {
                    Button("Save") {
                        // save
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review

                        try? moc.save()

                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }

}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
