# Overview
This sample app intends is to provide weather information from the following cities:

* Londres
* Montevideo
* Buenos Aires


![237449978-f533a0bc-3ff6-4253-8f50-38b34eac4502](https://github.com/tomasperotti/weather-sample-ios/assets/13985216/1c852ed1-7ed1-4080-a065-d95f96956e56)

# Architecture

The app follows the MVVM (Model-View-ViewModel) architecture, it also contains the following structured folders:
* UI: This folder owns the views used by the app.
* Presentation: This folder contains the ViewModel.
* Domain: This folder contains the Model's and the mapper.
* Data: This folder contains the DTO's structs.
* Core: This folder contains the networking client used in the app.

# How to use

The app is simple, just select the city you want (in the segmented control) and it will provide you information about the current weather in that location.



