//
//  WeatherExtraDetailsView.swift
//  AstroWeatherApp
//
//  Created by Tomás Perotti on 04/05/2023.
//

import SwiftUI

struct WeatherExtraDetailsView: View {
    
    var info: WeatherExtraInformationModel
    
    var body: some View {
        
        HStack(spacing: 20) {
            
            ImageTextView(text: info.humidity,
                          imageName: "drop.fill")

            ImageTextView(text: info.windSpeed,
                          imageName: "wind")
            
            ImageTextView(text: info.feelsLike,
                          imageName: "thermometer")
        }
        
    }
}

struct WeatherExtraDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherExtraDetailsView(info: .init(humidity: "30%", windSpeed: "5 mph", feelsLike: "70"))
    }
}
