//
//  ContentView.swift
//  HotProspects
//
//  Created by Brian Foshee on 20/5/22.
//

import SwiftUI
import SamplePackage


struct ContentView: View {
    let possibleNumbers = Array(1...60)
    var results: String {
        // SamplePackage provides this random function
        let selected = possibleNumbers.random(7).sorted()
        // convert those into strings
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }

    var body: some View {
        Text(results)
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
