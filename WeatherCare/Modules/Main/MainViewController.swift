//
//  MainViewController.swift
//  WeatherCare
//
//  Created by Vladislav Dyakov on 12.08.2020.
//  Copyright (c) 2020 Vladislav Dyakov. All rights reserved.
//

import CoreLocation
import UIKit

public protocol MainDisplayLogic: class {
    func displayData(viewModel: Main.Model.ViewModel)
}

public class MainViewController: UIViewController {
    
    // MARK: - UI elements
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var recomendationLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var howItFeelsLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    // MARK: - Services
    public var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    private var interactor: MainBusinessLogic?
    private let locationManager: CLLocationManager = CLLocationManager()
    
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
    }
    
    private func userInterfaceSetup() {
        self.cityLabel.text = "--"
        self.weatherDescriptionLabel.text = "--"
        self.weatherImageView.image = nil
        self.temperatureLabel.text = "--"
        self.windSpeedLabel.text = "--"
        self.howItFeelsLabel.text = "--"
        self.humidityLabel.text = "--"
    }
    
    // MARK: - Routing
    
    // MARK: - View lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        userInterfaceSetup()
        setupLocationManager()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.locationManager.startUpdatingLocation()
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Main logic
    private func setupLocationManager() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    public func gotCoordsRequest(lat: String, lon: String) {
        interactor?.makeRequest(request: .gotCoords(lat: lat, lon: lon))
    }
    
    public func gotCityRequest(city: String) {
        interactor?.makeRequest(request: .gotCity(city: city))
    }
    
    private func gotWeatherModel(model: WeatherModel) {
        self.cityLabel.text = model.cityName
        self.weatherDescriptionLabel.text = model.weatherDescription
        self.weatherImageView.image = model.weatherIcon
        self.temperatureLabel.text = model.degreesText
        self.windSpeedLabel.text = model.windSpeedText
        self.howItFeelsLabel.text = model.feelsLikeDegreesText
        self.humidityLabel.text = model.humidityText
    }
    
    private func showError(with message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    
    // MARK: - Actions
    @IBAction func otherCityButtonPressed(_ sender: RoundedButton) {
        let alert = UIAlertController(title: "Другой город", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Введите название города"
        })
        
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let city = alert.textFields?.first?.text {
                self.gotCityRequest(city: city)
            }
        }))

        self.present(alert, animated: true)
    }
    
    @IBAction func refreshButtonPressed(_ sender: RoundedButton) {
        self.locationManager.startUpdatingLocation()
    }
}

extension MainViewController: MainDisplayLogic {
    public func displayData(viewModel: Main.Model.ViewModel) {
        switch viewModel {
        case .gotWeatherModel(let model):
            gotWeatherModel(model: model)
        case .error(let message):
            showError(with: message)
        }
    }
}

//MARK: - Location Manager Delegate Methods
extension MainViewController: CLLocationManagerDelegate {

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        locationManager.stopUpdatingLocation()

        let lat = String(location.coordinate.latitude)
        let lon = String(location.coordinate.longitude)
        gotCoordsRequest(lat: lat, lon: lon)
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.showError(with: error.localizedDescription)
    }
}
