//
//  ContentView.swift
//  iExpense
//
//  Created by Brian Foshee on 23/4/22.
//

import SwiftUI

struct ContentView: View {
    // Expenses is a class so we need StateObject
    @StateObject var expenses = Expenses()

    // is the AddView showing
    @State private var showingAddEpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddEpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddEpense) {
                AddView(expenses: expenses)
            }
        }
    }

    func removeItems(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
