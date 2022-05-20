//
//  ContentView.swift
//  NameRemember
//
//  Created by Brian Foshee on 16/5/22.
//

import SwiftUI

struct ContentView: View {
    // image picker things
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?

    // temp things for setting up
    @State private var image: Image?

    var body: some View {
        NavigationView {
            List {
                image?
                    .resizable()
                    .scaledToFit()

            }
            .navigationTitle("Name Remember")
            .toolbar {
                Button {
                    showingImagePicker = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $selectedImage)
            }
            .onChange(of: selectedImage) { _ in addImage() }
        }
    }

    func addImage() {
        guard let selectedImage = selectedImage else {
            return
        }

        image = Image(uiImage: selectedImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
