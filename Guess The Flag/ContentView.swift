//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Brian Foshee on 2/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)
            Color.red.frame(width: 200, height: 200)
            Color.blue.frame(width: 100, height: 100)
            Text("Content")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
