//
//  ContentView.swift
//  Views and Modifiers
//
//  Created by Brian Foshee on 3/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("wtf")
            .prominentTitle()

    }
}

struct LargeBlue: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .font(.largeTitle)
    }
}

extension View {
    func prominentTitle() -> some View {
        return self.modifier(LargeBlue())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
