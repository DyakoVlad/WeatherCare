//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Vladislav Dyakov on 15.04.2020.
//  Copyright © 2020 Vladislav Dyakov. All rights reserved.
//

import Foundation

struct WeatherData: Equatable {
    let weatherDescription: [WeatherDescription]
    let temperatureInK: Double?
    let feelsLikeInK: Double?
    let windSpeed: Double?
    let cityName: String?
}

extension WeatherData: Decodable {
    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case wind
        case temperatureInK = "temp"
        case feelsLikeInK = "feels_like"
        case windSpeed = "speed"
        case cityName = "name"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.weatherDescription = try container.decode([WeatherDescription].self, forKey: .weather)
        let mainContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .main)
        self.temperatureInK = try mainContainer.decodeIfPresent(Double.self, forKey: .temperatureInK)
        self.feelsLikeInK = try mainContainer.decodeIfPresent(Double.self, forKey: .feelsLikeInK)
        let windContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .wind)
        self.windSpeed = try windContainer.decodeIfPresent(Double.self, forKey: .windSpeed)
        self.cityName = try container.decodeIfPresent(String.self, forKey: .cityName)
    }
}
