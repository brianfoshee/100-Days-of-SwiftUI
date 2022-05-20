//
//  NameImageView.swift
//  NameRemember
//
//  Created by Brian Foshee on 20/5/22.
//

import SwiftUI

struct NameImageView: View {
    @Environment(\.dismiss) var dismiss

    var image: Image?
    @Binding var name: String

    var body: some View {
        NavigationView {
            VStack {
                image?
                    .resizable()
                    .scaledToFit()

                TextField("Image Name", text: $name)
                    .padding()

                Spacer()
            }
            .navigationTitle("Name this Image")
            .toolbar {
                Button("Save") {
                    dismiss()
                }
            }
        }
    }
}

struct NameImageView_Previews: PreviewProvider {
    @State static var name = "brian"
    static var previews: some View {
        NameImageView(name: $name)
    }
}
