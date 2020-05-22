//
//  ContentView.swift
//  Drawing
//
//  Created by Brian Foshee on 21/5/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        // 0 degrees is to the right. this adjusts so 0 is up top.
        let angleAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - angleAdjustment
        let modifiedEnd = endAngle - angleAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2 - insetAmount,
                    startAngle: modifiedStart,
                    endAngle: modifiedEnd,
                    clockwise: !clockwise)
        return path
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct Flower: Shape {
    // how much to move this petal away from the center
    var petalOffset: Double = -20

    // how wide to make each petal
    var petalWidth: Double = 100

    func path(in rect: CGRect) -> Path {
        // the path that will hold all of the petals
        var path = Path()

        // count from 0 to pi * 2, moving up pi / 8 each time
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            // rotate the petal by the current value of our loop
            let rotation = CGAffineTransform(rotationAngle: number)

            // move the petal to be at the center of our view
            let position = rotation.concatenating(
                CGAffineTransform(translationX: rect.width / 2,
                                  y: rect.height / 2)
            )

            // create a path for this petal using our properties plus a fixed
            // Y and height
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset),
                                                       y: 0,
                                                       width: CGFloat(petalWidth),
                                                       height: rect.width / 2))

            // apply rotation/position transformation to the petal
            let rotatedPetal = originalPetal.applying(position)

            // add it to the main path
            path.addPath(rotatedPetal)
        }

        // send the path back
        return path
    }
}

struct ContentView: View {
    @State private var petalOffset: Double = -20
    @State private var petalWidth: Double = 100

    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                //.stroke(Color.red, lineWidth: 1)
                .fill(Color.red, style: FillStyle(eoFill: true))

            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])

            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
