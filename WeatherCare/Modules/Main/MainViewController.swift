//
//  MainViewController.swift
//  WeatherCare
//
//  Created by Vladislav Dyakov on 12.08.2020.
//  Copyright (c) 2020 Vladislav Dyakov. All rights reserved.
//

import UIKit

public protocol MainDisplayLogic: class {
    func displayData(viewModel: Main.Model.ViewModel)
}

public class MainViewController: UIViewController {
    
    // MARK: - UI elements
    private var descriptionModuleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .brown
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.text = "\(MainViewController.self)"
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Services
    public var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    private var interactor: MainBusinessLogic?
    
    // MARK: - Object lifecycle
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        userInterfaceSetup()
    }
    
    private func userInterfaceSetup() {
        view.backgroundColor = .white
        configureDescriptionTitle()
    }
    
    private func configureDescriptionTitle() {
        view.addSubview(descriptionModuleLabel)
        NSLayoutConstraint.activate([
            descriptionModuleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionModuleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionModuleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionModuleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Routing
    
    // MARK: - View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialRequest()
    }
    
    // MARK: - Main logic
    public func initialRequest() {
//        let request = Main.Model.Request()
//        interactor?.makeRequest(request: request)
    }
}

extension MainViewController: MainDisplayLogic {
    public func displayData(viewModel: Main.Model.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
