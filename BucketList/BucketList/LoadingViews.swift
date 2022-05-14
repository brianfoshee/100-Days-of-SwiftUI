//
//  LoadingViews.swift
//  BucketList
//
//  Created by Brian Foshee on 13/5/22.
//

import SwiftUI

struct LoadingViews: View {
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


struct LoadingViews_Previews: PreviewProvider {
    static var previews: some View {
        LoadingViews()
    }
}
