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
    
    // [도시 id: (화면 표시 순서, 도시 한글 이름)]
    private let cityInfoDict: [Int: (Int, String)] = [
        1842616: (0, "공주"), 1841811: (1, "광주"), 1842225: (2, "구미"), 1842025: (3, "군산"), 1835327: (4, "대구"),
        1835224: (5, "대전"), 1841066: (6, "목포"), 1838524: (7, "부산"), 1835895: (8, "서산"), 1835848: (9, "서울"),
        1836553: (10, "속초"), 1835553: (11, "수원"), 1835648: (12, "순천"), 1833747: (13, "울산"), 1843491: (14, "익산"),
        1845457: (15, "전주"), 1846266: (16, "제주시"), 1845759: (17, "천안"), 1845604: (18, "청주"), 1845136: (19, "춘천")
    ]
    
    public var weatherInfoList: [(Int?, WeatherResponse)] = []
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
    }
    
    // DetailViewController 에서 뒤로 넘어 왔을 경우에 날씨 새로고침
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchWeather(idDict: cityInfoDict)
    }
    
    func fetchWeather(idDict: [Int: (Int, String)]) {
        self.weatherInfoList = []
        var cityId = ""
        var cnt = 0
        for (id, (_, _)) in idDict {
            cityId += ("\(id),")
            cnt += 1
            // Group 으로 받아올 수 있는 최대 지역의 개수가 19개
            if (cnt % 19 == 0 || cnt == cityInfoDict.count) {
                WeatherService.shared.getWeatherList(cityID: cityId) { result in
                    switch result {
                    case .success(let weatherResponseList):
                        weatherResponseList.list.forEach { self.weatherInfoList.append((self.cityInfoDict[$0.id]?.0, $0)) }
                        DispatchQueue.main.async {
                            self.weatherInfoList.sort { $0.0 ?? 0 < $1.0 ?? 1 }
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
        
        cell.homeWeatherCellView.weatherIconImageView.setImageByIconID(id: weatherInfoList[indexPath.row].1.weather[0].icon)
        cell.homeWeatherCellView.locationLabel.text = self.cityInfoDict[weatherInfoList[indexPath.row].1.id]?.1
        cell.homeWeatherCellView.temperatureLabel.text = String(weatherInfoList[indexPath.row].1.main.temp) + "°C"
        cell.homeWeatherCellView.humidityLabel.text = String(weatherInfoList[indexPath.row].1.main.humidity) + "%"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.homeView.weatherInfoCollectionView.frame.width
        let height = self.homeView.weatherInfoCollectionView.frame.height
        
        
        return CGSize(width: width-20, height: height / 4.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailViewController") as? DetailViewController else { return }
        
        detailViewController.weatherInfo = self.weatherInfoList[indexPath.row].1
        detailViewController.cityName = self.cityInfoDict[self.weatherInfoList[indexPath.row].1.id]?.1
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
