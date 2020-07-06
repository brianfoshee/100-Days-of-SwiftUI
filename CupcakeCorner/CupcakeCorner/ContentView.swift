//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Brian Foshee on 27/6/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

class User: ObservableObject, Codable {
    @Published var name: String = "Brian Foshee"

    // required means that any subclass must override this init method
    // alternative is to make 'final class User' so that subclasses
    // are not allowed.
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }

    // satisfies Codable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

// part of conforming User class to Codable
enum CodingKeys: CodingKey {
    case name
}

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State private var results = [Result]()

    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .onAppear(perform: loadData)
    }

    func loadData() {
        guard let url: URL = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }

        let request: URLRequest = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, res, err in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    // we have good data, go back to the main thread
                    DispatchQueue.main.async {
                        // update UI
                        self.results = decodedResponse.results
                    }

                    // all good, exit
                    return
                }
            }

            // a problem occurred
            print("Fetch Failed: \(err?.localizedDescription ?? "unknown error")")
            print(String(describing: res))
        }.resume() // necessary to kick off the task (sends to background)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
