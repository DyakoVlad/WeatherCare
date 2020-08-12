//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Vladislav Dyakov on 15.04.2020.
//  Copyright © 2020 Vladislav Dyakov. All rights reserved.
//

import Foundation
import Moya

protocol WeatherService {
    func getWeatherDataByCoordinates(lat: String, lon: String, then handler: @escaping (Result<WeatherData, MoyaError>) -> Void)
    func getWeatherDataByCityName(name: String, then handler: @escaping (Result<WeatherData, MoyaError>) -> Void)
}

struct WeatherServiceImpl {
    init(provider: MoyaProvider<WeatherAPI>) {
        self.provider = provider
    }

    private let provider: MoyaProvider<WeatherAPI>
}

extension WeatherServiceImpl: WeatherService {
    func getWeatherDataByCoordinates(lat: String, lon: String, then handler: @escaping (Result<WeatherData, MoyaError>) -> Void) {
        self.provider.request(.getByCoorditates(lat: lat, lon: lon)) { result in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let weatherData = try filteredResponse.map(WeatherData.self)
                    handler(.success(weatherData))
                } catch let moyaError as MoyaError {
                    handler(.failure(moyaError))
                } catch {
                    handler(.failure(MoyaError.underlying(error, response)))
                }
            case .failure(let error):
                handler(.failure(MoyaError.underlying(error, nil)))
            }
        }
    }

    func getWeatherDataByCityName(name: String, then handler: @escaping (Result<WeatherData, MoyaError>) -> Void) {
        self.provider.request(.getByCityName(name: name)) { result in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let weatherData = try filteredResponse.map(WeatherData.self)
                    handler(.success(weatherData))
                } catch let moyaError as MoyaError {
                    handler(.failure(moyaError))
                } catch {
                    handler(.failure(MoyaError.underlying(error, response)))
                }
            case .failure(let error):
                handler(.failure(MoyaError.underlying(error, nil)))
            }
        }
    }
}
