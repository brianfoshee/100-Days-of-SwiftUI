//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Brian Foshee on 11/5/22.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    // Coordinator handles communication between the UIViewController
    // (PHPickerViewController in this case) and SwiftUI
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        // PHPickerViewController's one delegate method
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }

    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator // this is set by makeCoordinator()
        return picker
    }

    // empty func
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }

    // this is so SwiftUI knows which Coordinator to use
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

}
