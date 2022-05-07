//
//  DetailView.swift
//  BookWorm
//
//  Created by Brian Foshee on 6/5/22.
//

import CoreData
import SwiftUI

struct DetailView: View {
    let book: Book
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()

                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }

            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)

            Text(book.review ?? "No review")
                .padding()

            // using a constant binding here makes the view read-only
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "unknown")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/*
 this crashes
struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let book = Book(context: moc)
        book.title = "test book"
        book.author = "test author"
        book.genre = "fantasy"
        book.rating = 4
        book.review = "test review"

        return NavigationView {
            DetailView(book: book)
        }
    }
}

*/
