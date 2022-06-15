//
//  ContentView.swift
//  DiceRoll
//
//  Created by Brian Foshee on 14/6/22.
//

import SwiftUI

struct ContentView: View {
    @State private var diceValue = 1
    @State private var sides = 6

    let sideOptions = [4, 6, 8, 10, 12, 20, 100]

    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.black, lineWidth: 3)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)

                Text("\(diceValue)")
            }

            Button {
                rollDice()
            } label: {
                Text("Roll")
            }

            Spacer()

            Text("How many sides on the dice?")
            Picker("dice sides", selection: $sides) {
                ForEach(sideOptions, id: \.self) { n in
                    Text("\(n)")
                }
            }
            .pickerStyle(.segmented)
        }
    }

    func rollDice() {
        diceValue = Int.random(in: 1...sides)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
