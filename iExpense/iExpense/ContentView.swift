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

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    let expense = ExpenseItem(name: "Item", type: "personal", amount: 25.4)
                    expenses.items.append(expense)

                } label: {
                    Image(systemName: "plus")
                }
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
