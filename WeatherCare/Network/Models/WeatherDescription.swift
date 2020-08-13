
//
//  WeatherDescription.swift
//  WeatherApp
//
//  Created by Vladislav Dyakov on 15.04.2020.
//  Copyright © 2020 Vladislav Dyakov. All rights reserved.
//

import Foundation

struct WeatherDescription: Equatable, Decodable {
    let id: Int
    let description: String
    let icon: String
}
