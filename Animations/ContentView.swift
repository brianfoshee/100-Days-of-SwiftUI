//
//  ContentView.swift
//  Animations
//
//  Created by Brian Foshee on 9/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let letters = Array("Hello SwiftUI")
    @State private var enabled: Bool = false
    @State private var dragAmount: CGSize = CGSize.zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(self.letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(self.enabled ? Color.blue : Color.red)
                    .offset(self.dragAmount)
                    .animation(
                        Animation.default.delay(Double(num) / 20)
                )
            }
        }
        .gesture(
            DragGesture()
                .onChanged { drag in
                    self.dragAmount = drag.translation
                }
                .onEnded { _ in
                    self.dragAmount = .zero
                    self.enabled.toggle()
                }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
