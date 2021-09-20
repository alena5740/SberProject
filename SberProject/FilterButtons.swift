//
//  FilterButtons.swift
//  SberProject
//
//  Created by Алена on 09.09.2021.
//

import UIKit

// Фильтры для обработки фотографии
final class FilterButtons {
    private let context = CIContext()
    private let filtersNameArray = [CIFilter(name: "CIPhotoEffectChrome"), CIFilter(name: "CIPhotoEffectTonal"), CIFilter(name: "CIPhotoEffectFade"), CIFilter(name: "CIPhotoEffectInstant"), CIFilter(name: "CIPhotoEffectProcess"), CIFilter(name: "CIPhotoEffectTransfer")]

    func filterCIPhotoEffect(imageView: UIImageView, indexPath: Int) {
        guard let inputImage = imageView.image else { return }
        let filter = filtersNameArray[indexPath]
        let beginImage = CIImage(image: inputImage)
        
        filter?.setValue(beginImage, forKey: kCIInputImageKey)

        guard let outputImage = filter?.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            imageView.image = processedImage
        }
    }
}
