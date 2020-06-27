//
//  ContentView.swift
//  Moonshot
//
//  Created by Brian Foshee on 16/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State private var showingNames: Bool = false

    // associate astronauts with missions, and missions with astronauts
    // without passing both arrays through to all views

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination:
                MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)

                        if self.showingNames {
                            ForEach(mission.crew, id: \.name) { member in
                                Text("\(self.astronautNameFromCrew(member: member.name))")
                            }
                        } else {
                            Text(mission.formattedLaunchDate)
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(showingNames ? "Dates" : "Names") {
                self.showingNames.toggle()
            })
        }
    }

    func astronautNameFromCrew(member: String) -> String {
        if let match = astronauts.first(where: { $0.id == member }) {
            return match.name
        } else {
            return "N/A"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
