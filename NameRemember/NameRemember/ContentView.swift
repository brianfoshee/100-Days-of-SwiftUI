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
    @State private var faces = [Face]()
    
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

                        Button("Save") {
                            guard let selectedImage = selectedImage else {
                                return
                            }

                            let face = Face(image: selectedImage, name: imageName)
                            faces.append(face)

                            // reset values for another image
                            self.selectedImage = nil
                            self.image = nil
                            imageName = ""
                        }
                    }
                }

                ForEach(faces.sorted()) { face in
                    // show each face
                    NavigationLink {
                        Text(face.name)

                        face.displayableImage
                            .resizable()
                            .scaledToFit()
                    } label: {
                        VStack {
                            Text(face.name)
                                .font(.headline)

                            face.displayableImage
                                .resizable()
                                .scaledToFit()

                        }
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
