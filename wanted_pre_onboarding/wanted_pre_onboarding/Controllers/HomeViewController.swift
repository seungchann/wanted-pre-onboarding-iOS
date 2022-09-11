//
//  HomeViewController.swift
//  wanted_pre_onboarding
//
//  Created by 김승찬 on 2022/09/03.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Properties
    public var homeView: HomeView! {
        guard isViewLoaded else { return nil }
        return (view as! HomeView)
    }
    
    private let cityIDList: [(Int, String)] = [
        (1842616, "Gongju"), (1841811, "Gwangju"), (1842225, "Gumi"), (1842025, "Gunsan"), (1835327, "Daegu"),
        (1835224, "Daejeon"), (1841066, "Mokpo"), (1838524, "Busan"), (1835895, "Seosan City"), (1835848, "Seoul"),
        (1836553, "Sokcho"), (1835553, "Suwon-si"), (1835648, "Suncheon"), (1833747, "Ulsan"), (1843491, "Iksan"),
        (1845457, "Jeonju"), (1846266, "Jeju City"), (1845759, "Cheonan"), (1845136, "Chuncheon"), (1845604, "Cheongju-si")
    ]
    
    public var weatherInfoList: [WeatherResponse] = []
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
    }
    
    // DetailViewController 에서 뒤로 넘어 왔을 경우에 날씨 새로고침
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchWeather(idList: cityIDList)
    }
    
    func fetchWeather(idList: [(Int, String)]) {
        var cityId = ""
        for (idx, (id, _)) in cityIDList.enumerated() {
            cityId += ("\(id),")
            // Group 으로 받아올 수 있는 최대 지역의 개수가 19개
            if (idx+1) % 19 == 0 || idx == cityIDList.count-1 {
                WeatherService.shared.getWeatherList(cityID: cityId) { result in
                    switch result {
                    case .success(let weatherResponseList):
                        self.weatherInfoList = self.weatherInfoList + weatherResponseList.list
                        DispatchQueue.main.async {
                            self.homeView.weatherInfoCollectionView.reloadData()
                        }
                    case .failure(_):
                        print("==============================")
                        print("=====HomeViewController:fetchWeather=====")
                        print("=====WeatherResponseList 를 불러올 수 없습니다.=====")
                        print("==============================")
                    }
                }
                cityId = ""
            }
        }
    }
    
    private func setupLabels() {
        self.homeView.titleLabel.text = "날씨"
        self.homeView.titleLabel.font = UIFont.boldSystemFont(ofSize: 45)
        
        self.homeView.weatherInfoCollectionView.delegate = self
        self.homeView.weatherInfoCollectionView.dataSource = self
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weatherInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeWeatherCell", for: indexPath) as? HomeWeatherInfoCell else {
            return UICollectionViewCell()
        }
        
        cell.homeWeatherCellView.weatherIconImageView.setImageByIconID(id: weatherInfoList[indexPath.row].weather[0].icon)
        cell.homeWeatherCellView.locationLabel.text = weatherInfoList[indexPath.row].name
        cell.homeWeatherCellView.temperatureLabel.text = String(weatherInfoList[indexPath.row].main.temp) + "°C"
        cell.homeWeatherCellView.humidityLabel.text = String(weatherInfoList[indexPath.row].main.humidity) + "%"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.homeView.weatherInfoCollectionView.frame.width
        let height = self.homeView.weatherInfoCollectionView.frame.height
        
        
        return CGSize(width: width-20, height: height / 4.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailViewController") as? DetailViewController else { return }
        
        detailViewController.weatherInfo = self.weatherInfoList[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
