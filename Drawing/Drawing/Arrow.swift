//
//  Arrow.swift
//  Drawing
//
//  Created by Brian Foshee on 29/4/22.
//

import SwiftUI

struct Arrow: Shape {
    var length: Double = 2/3
    var thickness: Double = 1/3

    var animatableData: Double {
        get { thickness }
        set { thickness = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        // arrow wing overhang
        // arrow head height

        // begin at the bottom left, 1/3 over on the x axis
        path.move(to: CGPoint(x: rect.width * thickness, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.width * thickness, y: rect.height * (1 - length)))
        path.addLine(to: CGPoint(x: 0, y: rect.height * (1 - length)))

        // the tip of the arrow
        path.addLine(to: CGPoint(x: rect.width / 2, y: 0))

        path.addLine(to: CGPoint(x: rect.maxX, y: rect.height * (1 - length)))
        path.addLine(to: CGPoint(x: rect.width * (1 - thickness), y: rect.height * (1 - length)))
        path.addLine(to: CGPoint(x: rect.width * (1 - thickness), y: rect.maxY))

        return path
    }
}

struct Arrow_Previews: PreviewProvider {
    static var previews: some View {
        Arrow(length: 2/3, thickness: 1/3)
    }
}
