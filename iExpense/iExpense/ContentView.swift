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

    var currencyCode: String {
        let locale = Locale.current
        return locale.currencyCode ?? "USD"
    }

    var body: some View {
        NavigationView {
            List {
                Section("Personal Expenses") {
                    ForEach(expenses.personalItems()) { item in
                        ItemView(item: item, currencyCode: currencyCode)
                    }
                    .onDelete(perform: removeItems(type: "Personal"))
                }

                Section("Business Expenses") {
                    ForEach(expenses.businessItems()) { item in
                        ItemView(item: item, currencyCode: currencyCode)
                    }
                    .onDelete(perform: removeItems(type: "Business"))
                }
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
                AddView(expenses: expenses, currencyCode: currencyCode)
            }
        }
    }

    func removeItems(type: String) -> (IndexSet) -> Void {
        return { offset in
            var b: [ExpenseItem]
            if type == "Personal" {
                b = expenses.personalItems()
            } else {
                b = expenses.businessItems()
            }

            // can't do this bc the offsets are different for each section
            // expenses.items.remove(atOffsets: offset)
            for i in offset {
                // get UUID of this offset
                let id = b[i].id

                // find that UUID's position in expenses.items
                for j in 0..<expenses.items.count {
                    if expenses.items[j].id == id {
                        // delete that item
                        expenses.items.remove(at: j)
                        break
                    }
                }
            }
        }
    }

}

struct ItemView: View {
    var item: ExpenseItem
    var currencyCode: String

    var amountColor: Color {
        switch item.amount {
        case 0..<10:
            return .green
        case 10..<100:
            return .yellow
        default:
            return .red
        }
    }

    var body: some View {
        HStack {
            VStack {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }

            Spacer()
            Text(item.amount, format: .currency(code: currencyCode))
                .foregroundColor(amountColor)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
