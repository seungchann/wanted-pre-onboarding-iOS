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
    
    public static var cityId: Int = 1838524
    public static var cityName: String = "TEST"
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        fetchWeather(id: DetailViewController.cityId)
    }
    
    func setupLabels() {
        self.detailView.locationLabel.text = DetailViewController.cityName
        self.detailView.descriptionLabel.text = ""
        self.detailView.feelsTemperatureLabel.text = "Feels   "
        self.detailView.humidityLabel.text = "Humidity   "
        self.detailView.windLabel.text = "Wind   "
        self.detailView.pressureLabel.text = "Pressure   "
    }
    
    func fetchWeather(id: Int) {
        WeatherService.shared.getWeather(cityID: id) { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    let view = self.detailView
                    view?.locationLabel.text = weatherResponse.name
                    view?.weatherIconImageView.setImageByIconID(id: weatherResponse.weather[0].icon)
                    view?.descriptionLabel.text = weatherResponse.weather[0].description
                    view?.feelsTemperatureLabel.text = "Feels   \(weatherResponse.main.feels_like)°"
                    view?.humidityLabel.text = "Humidity   \(weatherResponse.main.humidity)%"
                    view?.windLabel.text = "Wind   \(weatherResponse.wind.speed)m/s"
                    view?.pressureLabel.text = "Pressure   \(weatherResponse.main.pressure)"
                }
            case .failure(_):
                print("error")
            }
        }
    }
}
