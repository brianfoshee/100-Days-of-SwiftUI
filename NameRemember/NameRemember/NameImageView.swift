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
    @State private var name = ""

    var onSave: (String) -> Void

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
                    onSave(name)
                    dismiss()
                }
            }
        }
    }
}

struct NameImageView_Previews: PreviewProvider {
    static var previews: some View {
        NameImageView(onSave: { _ in })
    }
}
