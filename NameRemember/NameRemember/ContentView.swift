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

    // naming image things
    @State private var showingNameImageSheet = false
    @State private var imageName = ""

    // temp things for setting up
    @State private var image: Image?

    var body: some View {
        NavigationView {
            List {
                image?
                    .resizable()
                    .scaledToFit()

                Text(imageName)
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
            .sheet(isPresented: $showingNameImageSheet) {
                NameImageView(image: image, name: $imageName)
            }
        }
    }

    func addImage() {
        guard let selectedImage = selectedImage else {
            return
        }

        image = Image(uiImage: selectedImage)
        showingNameImageSheet = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
