//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Brian Foshee on 7/5/22.
//

import SwiftUI

struct FilteredList: View {
    enum SingerPredicate: String {
        case beginsWith = "BEGINSWITH"
    }

    @FetchRequest var fetchRequest: FetchedResults<Singer>

    var body: some View {
        List(fetchRequest, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }

    init(filter: String, predicate: SingerPredicate, sortDescriptors: [SortDescriptor<Singer>]) {
        _fetchRequest = FetchRequest<Singer>(
            sortDescriptors: sortDescriptors,
            predicate: NSPredicate(format: "lastName \(predicate) %@", filter)
        )
    }
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList(filter: "A", predicate: .beginsWith, sortDescriptors: [SortDescriptor(\.lastName)])
    }
}
