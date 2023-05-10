//
//  ImageFromURLView.swift
//  AstroWeatherApp
//
//  Created by Tomás Perotti on 08/05/2023.
//

import Foundation
import SwiftUI

struct ImageFromURLView: View {
    @State private var image: UIImage?
    @State private var isAnimating = false

    var icon: String

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(isAnimating ? 1.2 : 1.0)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever())
                    .onAppear() {
                        self.isAnimating = true
                    }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            loadImage()
        }
    }

    private func loadImage() {
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
