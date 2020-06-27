//
//  AddView.swift
//  iExpense
//
//  Created by Brian Foshee on 16/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    
    @State private var name: String = ""
    @State private var type: String = "Personal"
    @State private var amount: String = ""

    @State private var isShowingAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""

    @Environment(\.presentationMode) var presentationMode

    static let types: [String] = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) { t in
                        Text(t)
                    }
                }

                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name,
                                           type: self.type,
                                           amount: actualAmount)
                    self.expenses.items.append(item)
                    self.expenses.items = self.expenses.items // bug in swift, fixed in 11.5
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.alertTitle = "Invalid amount"
                    self.alertMessage = "Amount cannot be \(self.amount)."
                    self.isShowingAlert.toggle()
                }
            })
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text(alertTitle),
                      message: Text(alertMessage),
                      dismissButton: .default(Text("Ok")) {
                        // todo
                    })
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}

