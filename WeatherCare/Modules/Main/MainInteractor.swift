//
//  MainInteractor.swift
//  WeatherCare
//
//  Created by Vladislav Dyakov on 12.08.2020.
//  Copyright (c) 2020 Vladislav Dyakov. All rights reserved.
//

import UIKit

public protocol MainBusinessLogic {
    func makeRequest(request: Main.Model.Request)
}

public protocol MainDataStore {
    //var name: String { get set }
}

public class MainInteractor: MainBusinessLogic, MainDataStore {
    // MARK: - Services
    public var presenter: MainPresentationLogic?
    //var name: String = ""
    
    // MARK: - Main logic
    public func makeRequest(request: Main.Model.Request) {
//        let response = Main.Model.Response()
//        presenter?.presentData(response: response)
    }
}
