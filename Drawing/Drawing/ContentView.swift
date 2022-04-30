//
//  ContentView.swift
//  Drawing
//
//  Created by Brian Foshee on 28/4/22.
//

import SwiftUI

struct ContentView: View {
    @State private var thickness = 0.3

    var body: some View {
        Arrow(length: 2/3, thickness: thickness)
            .onTapGesture {
                withAnimation {
                    thickness = Double.random(in: 0.1...0.5)
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
