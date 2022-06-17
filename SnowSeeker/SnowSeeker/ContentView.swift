//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Brian Foshee on 14/6/22.
//

import SwiftUI

struct ContentView: View {
    let resorts = Resort.allResorts

    var body: some View {
        NavigationView {
            List(resorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                        )

                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)

                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Resorts")

            // this is so that, on large devices, a welcome screen is shown on
            // first launch. Otherwise the list of resorts will be hidden without
            // any hint as to where they are.
            WelcomeView()
        }
    }

}

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to Snowseeker!")
                .font(.largeTitle)

            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                .foregroundColor(.secondary)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
            .previewDevice("iPhone 13 Pro Max")

        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
            .previewDevice("iPhone 13 mini")
    }
}
