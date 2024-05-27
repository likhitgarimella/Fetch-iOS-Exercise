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
    
    private var cache: [URL: Image] = [:]
    
    func getImage(for url: URL) -> Image? {
        return cache[url]
    }
    
    func setImage(_ image: Image, for url: URL) {
        cache[url] = image
    }
}

struct CachedAsyncImage: View {
    let url: URL
    
    @State private var image: Image? = nil
    
    var body: some View {
        if let image = image {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Rectangle()
                .foregroundColor(.gray.opacity(0.1))
                .onAppear {
                    loadImage()
                }
        }
    }
    
    private func loadImage() {
        if let cachedImage = ImageCache.shared.getImage(for: url) {
            self.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let uiImage = UIImage(data: data) {
                    let loadedImage = Image(uiImage: uiImage)
                    ImageCache.shared.setImage(loadedImage, for: url)
                    DispatchQueue.main.async {
                        self.image = loadedImage
                    }
                }
            }.resume()
        }
    }
}
