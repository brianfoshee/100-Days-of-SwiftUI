//
//  MissionCardView.swift
//  Moonshot
//
//  Created by Brian Foshee on 27/4/22.
//

import SwiftUI

struct MissionCardView: View {
    let mission: Mission
    let astronauts: [String: Astronaut]
    var body: some View {
        NavigationLink {
            MissionView(mission: mission, astronauts: astronauts)
        } label: {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding()

                VStack {
                    Text(mission.displayName)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(mission.formattedLaunchDate)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.5))
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(.lightBackground)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.lightBackground)
            }
        }
    }
}

struct MissionCardView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionCardView(mission: missions[0], astronauts: astronauts)
    }
}
