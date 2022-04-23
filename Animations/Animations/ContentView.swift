//
//  ContentView.swift
//  Animations
//
//  Created by Brian Foshee on 20/4/22.
//

import SwiftUI

struct ContentView: View {
    // the amount of drag
    @State private var dragAmount = CGSize.zero
    @State private var enabled = false
    let letters = Array("Hello SwiftUI")

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.default.delay(Double(num) / 20 ), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
