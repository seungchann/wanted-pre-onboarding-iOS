//
//  DetailViewController.swift
//  wanted_pre_onboarding
//
//  Created by 김승찬 on 2022/09/10.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Properties
    public var detailView: DetailView! {
        guard isViewLoaded else { return nil }
        return (view as! DetailView)
    }
    
    public var weatherInfo: WeatherResponse?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
    }
    
    func setupLabels() {
        let view = self.detailView
        let info = self.weatherInfo
        view?.locationLabel.text = info?.name
        view?.weatherIconImageView.setImageByIconID(id: info?.weather[0].icon ?? "")
        view?.descriptionLabel.text = info?.weather[0].description
        view?.feelsTemperatureLabel.text = "Feels   \(info?.main.feels_like ?? 0)°"
        view?.humidityLabel.text = "Humidity   \(info?.main.humidity ?? 0)%"
        view?.windLabel.text = "Wind   \(info?.wind.speed ?? 0)m/s"
        view?.pressureLabel.text = "Pressure   \(info?.main.pressure ?? 0)"
    }
}
