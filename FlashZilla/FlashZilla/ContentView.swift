//
//  ContentView.swift
//  FlashZilla
//
//  Created by Brian Foshee on 22/5/22.
//

import SwiftUI

struct ContentView: View {
    // how far the circle has been dragged
    @State private var offset = CGSize.zero

    // whether it's being dragged
    @State private var isDragging = false

    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }

        let longPressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }

        let combined = longPressGesture.sequenced(before: dragGesture)

        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5: 1)
            .offset(offset)
            .gesture(combined)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
