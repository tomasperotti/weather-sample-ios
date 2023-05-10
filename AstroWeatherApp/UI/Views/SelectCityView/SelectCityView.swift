//
//  SelectCityView.swift
//  AstroWeatherApp
//
//  Created by Tomás Perotti on 08/05/2023.
//

import SwiftUI

struct SelectCityView: View {
    @State private var selection = 0

    var body: some View {
        
        VStack {
            Picker(selection: $selection, label: Text("")) {
                Text("London").tag(0)
                Text("Montevideo").tag(1)
                Text("Buenos Aires").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            TabView(selection: $selection) {
                CurrentWeatherView(place: "London",
                                   lat: 51.507218,
                                   long: -0.127586)
                    .tag(0)
                CurrentWeatherView(place: "Montevideo",
                                   lat: -34.818159,
                                   long: -56.213826)
                    .tag(1)
                CurrentWeatherView(place: "Buenos Aires",
                                   lat: -37.201728,
                                   long: -59.84107)
                    .tag(2)
            }
            .edgesIgnoringSafeArea(.all)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
    }
}

struct SelectCityView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCityView()
    }
}
