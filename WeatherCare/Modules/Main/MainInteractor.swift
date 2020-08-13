//
//  MainInteractor.swift
//  WeatherCare
//
//  Created by Vladislav Dyakov on 12.08.2020.
//  Copyright (c) 2020 Vladislav Dyakov. All rights reserved.
//

import Foundation
import Moya

public protocol MainBusinessLogic {
    func makeRequest(request: Main.Model.Request)
}

public protocol MainDataStore {
    //var name: String { get set }
}

public final class MainInteractor: MainBusinessLogic, MainDataStore {
    // MARK: - Services
    public var presenter: MainPresentationLogic?
    private let weatherService: WeatherService
    
    init() {
        let provider = MoyaProvider<WeatherAPI>(
            callbackQueue: DispatchQueue.global(qos: .utility),
            plugins: []
        )
        self.weatherService = WeatherServiceImpl(provider: provider)
    }
    
    // MARK: - Main logic
    public func makeRequest(request: Main.Model.Request) {
        switch request {
        case .gotCoords(let lat, let lon):
            getWeatherData(lat: lat, lon: lon)
        }
    }
    
    private func getWeatherData(lat: String, lon: String) {
        self.weatherService.getWeatherDataByCoordinates(lat: lat, lon: lon) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weatherData):
                self.presenter?.presentData(response: .gotWeaterData(data: weatherData))
            case .failure(let error):
                self.errorResponse(message: error.localizedDescription)
            }
        }
    }
    
    private func errorResponse(message: String?) {
        guard let message = message else { return }
        presenter?.presentData(response: .error(message: message))
    }
}
