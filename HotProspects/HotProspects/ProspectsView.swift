//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Brian Foshee on 21/5/22.
//

import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }

    let filter: FilterType

    // this reads from ContentView's instance of prospects through .environmentObject
    @EnvironmentObject var prospects: Prospects

    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case.uncontacted:
            return "Uncontacted people"
        }
    }

    var body: some View {
        NavigationView {
            Text("People: \(prospects.people.count)")
                .navigationTitle(title)
                .toolbar {
                    Button {
                        let prospect = Prospect()
                        prospect.name = "Paul Hudson"
                        prospect.emailAddress = "paul@hackingwithswift.com"
                        prospects.people.append(prospect)
                    } label: {
                        Label("Scal", systemImage: "qrcode.viewfinder")
                    }
                }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var prospects = Prospects()
    static var previews: some View {
        ProspectsView(filter: .none)
        // all tabs are children of TabView and as such will receive this env object
            .environmentObject(prospects)
    }
}
