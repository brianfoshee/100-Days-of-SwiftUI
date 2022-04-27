//
//  ContentView.swift
//  Moonshot
//
//  Created by Brian Foshee on 25/4/22.
//

import SwiftUI

struct ContentView: View {
    // showing a grid vs a list
    @State private var grid = true

    // since decode takes generic types, need to specify the types of these vars
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        NavigationView {
            // swictch between grid and list
            if grid {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(missions) { mission in
                            MissionCardView(mission: mission, astronauts: astronauts)
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                .navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .toolbar {
                    Button("List") {
                        grid.toggle()
                    }
                }
            } else {
                List(missions) { mission in
                    // meh doesn't look great but works
                    MissionCardView(mission: mission, astronauts: astronauts)
                }
                .navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .toolbar {
                    Button("Grid") {
                        grid.toggle()
                    }
                }
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
