//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Brian Foshee on 29/5/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in CGFloat(position) * -10 }
                    // .alignmentGuide(.leading) { d in d[.trailing] }
            }
        }
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.blue)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
