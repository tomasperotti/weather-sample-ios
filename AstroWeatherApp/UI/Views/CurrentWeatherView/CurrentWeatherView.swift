//
//  CurrentWeatherView.swift
//  AstroWeatherApp
//
//  Created by Tomás Perotti on 04/05/2023.
//

import SwiftUI

struct CurrentWeatherView: View {
    
    @StateObject var viewModel = CurrentWeatherViewModel()
    var place: String
    var lat: Double
    var long: Double
    
    var body: some View {
        ZStack {
            
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                
                if let model = viewModel.data {
                    
                    
                    VStack(alignment: .center, spacing: 20) {
                        
                        Text(place)
                            .foregroundColor(.white)
                            .font(.system(size: 50))
                            .bold()
                        
                        Text(model.description.capitalized)
                            .foregroundColor(.white)
                            .font(.title2)
                            .bold()
                        
                        ImageFromURLView(icon: model.icon)
                            .frame(width: 100, height: 100)
                        
                        Text("\(model.temp)°")
                            .foregroundColor(.white)
                            .font(.system(size: 80))
                            .bold()
                            .foregroundColor(.black)
                            .shadow(radius: 10)
                        
                        HStack(spacing: 60) {
                            Text("Max: \(model.tempMax)")
                                .foregroundColor(.black)
                                .font(.headline)
                                .bold()
                            
                            Text("Min: \(model.tempMin)")
                                .foregroundColor(.black)
                                .font(.headline)
                                .bold()
                        }
                        
                        Spacer()
                        
                        WeatherExtraDetailsView(
                            info: .init(
                                humidity:"\(model.humidity)",
                                windSpeed: "\(model.windSpeed) km/h",
                                feelsLike: "\(model.feelsLike)°"
                            )
                        )
                        
                    }.padding(.top, 60)
                    
                }
            }
        }.onAppear {
            viewModel.fetchData(from: (lat: lat,
                                       long: long))
        }
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(place: "New York",
                           lat: -38.718318,
                           long: -62.266348)
    }
}
