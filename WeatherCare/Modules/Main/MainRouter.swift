//
//  MainRouter.swift
//  WeatherCare
//
//  Created by Vladislav Dyakov on 12.08.2020.
//  Copyright (c) 2020 Vladislav Dyakov. All rights reserved.
//

import UIKit

@objc
public protocol MainRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

public protocol MainDataPassing {
    var dataStore: MainDataStore? { get }
}

public class MainRouter: NSObject, MainRoutingLogic, MainDataPassing {
    
    // MARK: - Services
    public weak var viewController: MainViewController?
    public var dataStore: MainDataStore?
    
    // MARK: - Routing
    //func routeToSomewhere(segue: UIStoryboardSegue?) {
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: - Passing data
    //func passDataToSomewhere(source: MainDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
