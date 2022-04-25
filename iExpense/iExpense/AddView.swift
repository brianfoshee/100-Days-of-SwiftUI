//
//  AddView.swift
//  iExpense
//
//  Created by Brian Foshee on 24/4/22.
//

import SwiftUI

struct AddView: View {
    // swift figures out the type automatically
    @Environment(\.dismiss) var dismiss

    // if not being created, only used, use ObservedObject. State Object is for creating.
    @ObservedObject var expenses: Expenses

    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id:\.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)

            }
            .navigationTitle("Add new Expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    
                    // this is passed in, and a class, to actually modifying the ContentView's original
                    // copy of the object.
                    expenses.items.append(item)
                    
                    dismiss()
                }
            }
        }
    }

}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
