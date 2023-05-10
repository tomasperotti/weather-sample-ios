//
//  ExtraDetailView.swift
//  AstroWeatherApp
//
//  Created by Tomás Perotti on 04/05/2023.
//

import SwiftUI

struct ImageTextView: View {
    var text: String
    var imageName: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: imageName)
                .font(.system(size: 30))
                .foregroundColor(.white)
                .shadow(radius: 10)
            
            Text(text)
                .font(.headline)
                .shadow(radius: 10)
        }
    }
}

struct ImageTextView_Previews: PreviewProvider {
    static var previews: some View {
        ImageTextView(text: "70%", imageName: "drop.fill")
    }
}
