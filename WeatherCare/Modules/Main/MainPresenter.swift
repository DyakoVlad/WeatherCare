//
//  MainPresenter.swift
//  WeatherCare
//
//  Created by Vladislav Dyakov on 12.08.2020.
//  Copyright (c) 2020 Vladislav Dyakov. All rights reserved.
//

import UIKit

public protocol MainPresentationLogic {
    func presentData(response: Main.Model.Response)
}

public class MainPresenter: MainPresentationLogic {
    public weak var viewController: MainDisplayLogic?
    
    // MARK: - Presenting logic
    public func presentData(response: Main.Model.Response) {
        DispatchQueue.main.async {
            switch response {
            case .gotWeaterData(let data):
                let model = WeatherModel(cityName: data.cityName,
                                         weatherDescription: data.weatherDescription[0].description.prefix(1).uppercased() + data.weatherDescription[0].description.dropFirst(),
                                         weatherIcon: UIImage(named: String(data.weatherDescription[0].icon.dropLast())),
                                         degreesText: "\(Int(data.temperatureInK - 273.15))°",
                    windSpeedText: "\(data.windSpeed) км/ч",
                    feelsLikeDegreesText: "\(Int(data.feelsLikeInK - 273.15))°",
                    humidityText: "\(data.humidity)%")
                
                self.viewController?.displayData(viewModel: .gotWeatherModel(model: model))
            case .error(let message):
                self.viewController?.displayData(viewModel: .error(message: message))
            }
        }
    }
}
