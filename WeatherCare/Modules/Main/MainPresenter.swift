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
                let recomendation = self.getRecomendation(with: data.weatherDescription[0].id, temperature: Int(data.temperatureInK - 273.15))
                self.viewController?.displayData(viewModel: .gotRecomendation(text: recomendation))
            case .error(let message):
                self.viewController?.displayData(viewModel: .error(message: message))
            }
        }
    }
    
    private func getRecomendation(with id: Int, temperature: Int) -> String {
        var recomendation: String = getClothRecomendation(for: temperature)
        switch id {
        case 200...232, 300...321, 500...531, 600...622:
            recomendation += " и взять зонт"
        case 700...781:
            recomendation += ". Будьте осторожны на улице"
        default:
            ()
        }
        return recomendation
    }
    
    private func getClothRecomendation(for temperature: Int) -> String {
        let recomendation: String
        if temperature > 25 {
            recomendation = "Рекомендуется не надевать куртку"
        } else if temperature > 15 {
            recomendation = "Рекомендуется надеть легкую куртку"
        } else if temperature > 5 {
            recomendation = "Рекомендуется надеть осеннюю куртку"
        } else if temperature > -5 {
            recomendation = "Рекомендуется надеть теплую куртку"
        } else {
            recomendation = "Рекомендуется надеть зимнюю куртку"
        }
        return recomendation
    }
}
