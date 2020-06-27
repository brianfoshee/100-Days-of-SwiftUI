//
//  AstronautView.swift
//  Moonshot
//
//  Created by Brian Foshee on 17/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut

    // not ideal way to do this
    static let missions: [Mission] = Bundle.main.decode("missions.json")

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                    .padding()

                    Text("Missions")
                        .font(.title)
                        //.padding()

                    ForEach(self.myMissions()) { mission in
                        Text(mission.displayName)
                        .padding(5)
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }

    func myMissions() -> [Mission] {
        var out: [Mission] = [Mission]()

        for mission in Self.missions {
            if let _ = mission.crew.first(where: { $0.name == astronaut.id }) {
                out.append(mission)
            }
        }

        return out
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[7])
    }
}
