//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Vladislav Dyakov on 15.04.2020.
//  Copyright © 2020 Vladislav Dyakov. All rights reserved.
//

import Moya

enum WeatherAPI {
    case getByCoorditates(lat: String, lon: String)
    case getByCityName(name: String)
}

extension WeatherAPI: TargetType {

    var baseURL: URL {
        return URL(string: AppConstants.baseURL)!
    }

    var path: String {
        switch self {
        case .getByCoorditates:
            return "weather/"
        case .getByCityName:
            return "weather/"
        }
    }

    var method: Method {
        switch self {
        case .getByCoorditates:
            return .get
        case .getByCityName:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getByCoorditates(let lat, let lon):
            let parameters: [String : String] = ["lat": lat, "lon": lon, "appid": AppConstants.weatherAppId, "lang": "ru"]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .getByCityName(let name):
            let parameters: [String : String] = ["q": name, "appid": AppConstants.weatherAppId, "lang": "ru"]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return [:]
    }
}
