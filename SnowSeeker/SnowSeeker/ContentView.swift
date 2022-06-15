//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Brian Foshee on 14/6/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        if sizeClass == .compact {
            VStack {
                UserView()
            }
        } else {
            HStack {
                UserView()
            }
        }
    }

}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
