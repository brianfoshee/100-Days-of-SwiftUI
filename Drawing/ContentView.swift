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

struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    func path(in rect: CGRect) -> Path {
        // 0 degrees is to the right. this adjusts so 0 is up top.
        let angleAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - angleAdjustment
        let modifiedEnd = endAngle - angleAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2,
                    startAngle: modifiedStart,
                    endAngle: modifiedEnd,
                    clockwise: clockwise)
        return path
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Triangle()
                .fill(Color.red)
                .frame(width: 200, height: 200)

            Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
                .stroke(Color.blue, lineWidth: 10)
                .frame(width: 200, height: 120)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
