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

    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
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
