//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Brian Foshee on 11/5/22.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        return picker
    }

    // empty func
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
}
