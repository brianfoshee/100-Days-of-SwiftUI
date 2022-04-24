//
//  ContentView.swift
//  iExpense
//
//  Created by Brian Foshee on 23/4/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false
    var body: some View {
        Button("show the view") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "brian")
        }
    }
}

struct SecondView: View {
    let name: String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button("Hello, \(name)") {
            dismiss()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
