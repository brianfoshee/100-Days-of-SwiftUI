//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Brian Foshee on 14/6/22.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedUser: User? = nil
    var body: some View {
        Text("Hello")
            .onTapGesture {
                selectedUser = User()
            }
            .sheet(item: $selectedUser) { user in
                Text(user.id)
            }
    }

}

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
