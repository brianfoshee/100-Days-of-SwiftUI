//
//  ContentView.swift
//  FlashZilla
//
//  Created by Brian Foshee on 22/5/22.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        CardView(card: Card.example)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
