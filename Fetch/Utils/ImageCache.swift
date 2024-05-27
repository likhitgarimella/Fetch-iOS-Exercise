//
//  ImageCache.swift
//  Fetch
//
//  Created by Likhit Garimella on 5/25/24.
//

import Foundation
import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    private init() {}
    
    private var cache: [URL: Image] = [:]   // dict to store cached images
    
    func getImage(for url: URL) -> Image? { // get an image from cache for a given url
        return cache[url]
    }
    
    func setImage(_ image: Image, for url: URL) {   // set an image in cache for a given url
        cache[url] = image
    }
}

struct CachedAsyncImage: View {
    let url: URL    // url of image
    
    @State private var image: Image? = nil  // loaded image
    
    var body: some View {
        if let image = image {  // if image is loaded, display it
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Rectangle() // placeholder
                .foregroundColor(.gray.opacity(0.1))
                .onAppear {
                    loadImage()
                }
        }
    }
    
    private func loadImage() {
        if let cachedImage = ImageCache.shared.getImage(for: url) { // check if image is in cache
            self.image = cachedImage    // if so, display cached image
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in    // if not, download the image
                if let data = data, // check if data is valid
                   let uiImage = UIImage(data: data) {  // convert it to UIImage
                    let loadedImage = Image(uiImage: uiImage)   // convert UIImage to SwiftUI's Image
                    ImageCache.shared.setImage(loadedImage, for: url)   // store the image in cache
                    DispatchQueue.main.async {
                        self.image = loadedImage    // update image state
                    }
                }
            }.resume()
        }
    }
}
