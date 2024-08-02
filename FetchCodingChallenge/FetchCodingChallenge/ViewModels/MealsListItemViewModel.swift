//
//  MealsListItemViewModel.swift
//  FetchCodingChallenge
//
//  Created by Justin Rudolph on 7/30/24.
//

import SwiftUI

// The ViewModel is responsible for handling the logic of fetching meal images from the URL and caching them

class MealsListItemViewModel: ObservableObject {
    @Published var image: UIImage?
    private var url: URL?
    private static let cache = NSCache<NSURL, UIImage>()  // Static cache to store loaded images and avoid redundant network requests
    
    // Initializer accepting a URL as the parameter
    init(url: URL?) {
        self.url = url
        Task {
            await loadImage()
        }
    }
    
    // Function to load the image from the URL
    private func loadImage() async {
        guard let url = url else { return }
        
        // Check if the image is already cached
        if let cachedImage = MealsListItemViewModel.cache.object(forKey: url as NSURL) {
            self.image = cachedImage  // Use the cached image if available
            return
        }
        
        do {
            // Fetch the image from the network if not cached
            let (data, _) = try await URLSession.shared.data(from: url)
            if let downloadedImage = UIImage(data: data) {
                MealsListItemViewModel.cache.setObject(downloadedImage, forKey: url as NSURL)  // Cache the image once it is loaded
                DispatchQueue.main.async { [weak self] in
                    self?.image = downloadedImage  // Update the published image property on the main thread
                }
            }
        } catch {
            print("Error loading image: \(error.localizedDescription)")
        }
    }
}
