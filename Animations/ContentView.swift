//
//  ContentView.swift
//  Animations
//
//  Created by Brian Foshee on 9/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingRed: Bool = false


    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    self.isShowingRed.toggle()
                }
            }
            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(
//                        .asymmetric(insertion: .scale,
//                                    removal: .opacity)
                        .pivot
                )
            }
        }
    }
}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content.rotationEffect(
            .degrees(amount),
            anchor: anchor
        )
        .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
