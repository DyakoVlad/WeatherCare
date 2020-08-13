//
//  MainModels.swift
//  WeatherCare
//
//  Created by Vladislav Dyakov on 12.08.2020.
//  Copyright (c) 2020 Vladislav Dyakov. All rights reserved.
//

import UIKit

public enum Main {
    public enum Model {
        public enum Request {
            case gotCoords(lat: String, lon: String)
            case gotCity(city: String)
        }
        
        public enum Response {
            case gotWeaterData(data: WeatherData)
            case error(message: String)
        }
        
        public enum ViewModel {
            case gotWeatherModel(model: WeatherModel)
            case error(message: String)
        }
    }
}

public struct WeatherModel {
    let cityName: String
    let weatherDescription: String
    let weatherIcon: UIImage?
    let degreesText: String
    let windSpeedText: String
    let feelsLikeDegreesText: String
    let humidityText: String
}
