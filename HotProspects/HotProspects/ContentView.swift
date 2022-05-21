//
//  ContentView.swift
//  HotProspects
//
//  Created by Brian Foshee on 20/5/22.
//

import SwiftUI


struct ContentView: View {
    @State private var backgroundColor = Color.red

    var body: some View {
        VStack {
            // swipe actions stuff
            List {
                Text("Taylor Swift")
                    .swipeActions {
                        Button(role: .destructive) {
                            print("Hi")
                        } label: {
                            Label("Delete", systemImage: "minus.circle")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            print("Hi")
                        } label: {
                            Label("Pin", systemImage: "pin")
                        }
                        .tint(.orange)
                    }
            }
            // context menu stuff
            Text("Hello World")
                .padding()
                .background(backgroundColor)

            Text("Change Color")
                .padding()
                .contextMenu {
                    Button {
                        backgroundColor = .red
                    } label: {
                        Label("Red", systemImage: "checkmark.circle.fill")
                    }
                    
                    Button("Green") {
                        backgroundColor = .green
                    }

                    Button("Blue") {
                        backgroundColor = .blue
                    }
                }
        }
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
