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
    @State private var image: Image?

    // naming image things
    @State private var imageName = ""

    // need an array of objects that has an image and a string
    
    var body: some View {
        NavigationView {
            List {
                if image != nil {
                    VStack {
                        Text("Name this face")
                            .font(.headline)

                        HStack {
                            image?
                                .resizable()
                                .scaledToFit()

                            TextField("Image Name", text: $imageName)
                        }

                        Button("Save") { }
                    }
                }
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
