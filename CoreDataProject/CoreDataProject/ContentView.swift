//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Brian Foshee on 6/5/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(sortDescriptors: [], predicate: nil) var ships: FetchedResults<Ship>

    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "unknown")
            }
            Button("Add Examples") {
                let ship1 = Ship(context: moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"

                let ship2 = Ship(context: moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"

                try? moc.save()
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var dataController = DataController()
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}
