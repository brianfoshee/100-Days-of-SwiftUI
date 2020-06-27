//
//  ContentView.swift
//  Spirograph
//
//  Created by Brian Foshee on 26/6/20.
//  Copyright © 2020 Brian Foshee. All rights reserved.
//

import SwiftUI

struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: CGFloat

    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
            var b = b

            while b != 0 {
                let temp = b
                    b = a % b
                    a = temp
            }

        return a
    }

    func path(in rect: CGRect) -> Path {
        let divisor: Int = gcd(innerRadius, outerRadius)
        let outerRadius: CGFloat = CGFloat(self.outerRadius)
        let innerRadius: CGFloat = CGFloat(self.innerRadius)
        let distance: CGFloat = CGFloat(self.distance)
        let difference: CGFloat = innerRadius - outerRadius
        let endPoint: CGFloat = ceil(2 * CGFloat.pi * outerRadius / CGFloat(divisor)) * amount

        var path = Path()

        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)

            x += rect.width / 2
            y += rect.height / 2

            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }

        return path
    }
}

struct ContentView: View {
    @State private var innerRadius: Double = 125.0
    @State private var outerRadius: Double = 75.0
    @State private var distance: Double = 25.0
    @State private var amount: CGFloat = 1.0
    @State private var hue: Double = 0.6

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            Spirograph(innerRadius: Int(innerRadius),
                       outerRadius: Int(outerRadius),
                       distance: Int(distance),
                       amount: amount)
                .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                .frame(width: 300, height: 300)

            Spacer()

            Group {
                Text("Inner Radius: \(Int(innerRadius))")
                Slider(value: $innerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])

                Text("Outer Radius: \(Int(outerRadius))")
                Slider(value: $outerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])

                Text("Distance: \(Int(distance))")
                Slider(value: $distance, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])

                Text("Amount: \(amount, specifier: "%.2f")")
                Slider(value: $innerRadius)
                    .padding([.horizontal, .bottom])

                Text("Color")
                Slider(value: $hue)
                    .padding([.horizontal])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
