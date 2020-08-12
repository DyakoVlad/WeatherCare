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
//        let viewModel = Main.Model.ViewModel()
//        viewController?.displayData(viewModel: viewModel)
    }
}
