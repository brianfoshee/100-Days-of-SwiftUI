//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Brian Foshee on 16/4/22.
//

import SwiftUI

// custom modifier. must conform to ViewModifier.
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("hello")
                .modifier(Title())

            // the extension doesn't need the .modifier thing
            Text("wat")
                .titleStyle()
        }
    }
}

// create modifiers as extensions of View to make them easier to use
extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
