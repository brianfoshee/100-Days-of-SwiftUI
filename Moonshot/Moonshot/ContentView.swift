//
//  ContentView.swift
//  Moonshot
//
//  Created by Brian Foshee on 25/4/22.
//

import SwiftUI

struct ContentView: View {
    // since decode takes generic types, need to specify the types of these vars
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    var body: some View {
        Text("\(astronauts.count)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
