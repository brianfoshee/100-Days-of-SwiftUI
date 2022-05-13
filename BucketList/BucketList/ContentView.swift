//
//  ContentView.swift
//  BucketList
//
//  Created by Brian Foshee on 13/5/22.
//

import SwiftUI

struct ContentView: View {
    @State private var outputOrError: String = ""

    var body: some View {
        HStack {
            Text("Test")
                .onTapGesture {
                    let str = "Test Message"
                    let url = FileManager.userDocumentsDirectory().appendingPathComponent("message.txt")

                    do {
                        try str.write(to: url, atomically: true, encoding: .utf8)
                        let input = try String(contentsOf: url)
                        outputOrError = input
                    } catch {
                        outputOrError = error.localizedDescription
                    }
                }

            Text(outputOrError)
        }
    }
}

extension FileManager {
    static func userDocumentsDirectory() -> URL {
        // find all possible documents directories
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        //just use the first one, which should be the only one
        return paths[0]
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
