//
//  ContentView.swift
//  Instafilter
//
//  Created by Brian Foshee on 9/5/22.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }

    func loadImage() {
        guard let inputImage = UIImage(named: "dog") else { return }
        let beginImage = CIImage(image: inputImage)

        let context = CIContext()
        let currentFilter = CIFilter.twirlDistortion()
        currentFilter.inputImage = beginImage

        let amount = 1.0

        // ask the filter whether these params are supported and set them if so
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
        }

        // get a CIImage
        guard let outputImage = currentFilter.outputImage else { return }
        // CGImage from CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert to UIImage
            let uiImg = UIImage(cgImage: cgimg)

            // convert to Image
            image = Image(uiImage: uiImg)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
