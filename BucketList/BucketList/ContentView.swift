//
//  ContentView.swift
//  BucketList
//
//  Created by Brian Foshee on 13/5/22.
//

import SwiftUI

struct ContentView: View {
    var loadingState = LoadingState.loading

    var body: some View {
        if loadingState == .loading {
            LoadingView()
        } else if loadingState == .success {
            SuccessView()
        } else {
            FailedView() 
        }
    }

}

enum LoadingState {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

extension FileManager {
    static func userDocumentsDirectory() -> URL {
        // find all possible documents directories
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        //just use the first one, which should be the only one
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
