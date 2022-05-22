//
//  MeView.swift
//  HotProspects
//
//  Created by Brian Foshee on 21/5/22.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @State private var name = "anonymous"
    @State private var emailAddress = "you@you.com"
    @State private var qrCode = UIImage()

    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)

                TextField("Email address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)

                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        Button {
                            // save
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: qrCode)
                        } label: {
                            Label("Save to Photos", systemImage: "square.and.arrow.down")
                        }
                    }
            }
            .navigationTitle("Your Code")
            .onAppear(perform: updateCode)
            .onChange(of: name) { _ in updateCode() }
            .onChange(of: emailAddress) { _ in updateCode() }

        }
    }

    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }

    func updateCode() {
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }

}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
