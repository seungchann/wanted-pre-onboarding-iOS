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
    
    public let locations: [String] = [
        "공주", "광주", "구미", "군산", "대구",
        "대전", "목포", "부산", "서산", "서울",
        "속초", "수원", "순천", "울산", "익산",
        "전주", "제주시", "천안", "청주", "춘천"
    ]
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
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
        return self.locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeWeatherCell", for: indexPath) as? HomeWeatherInfoCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .white
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 10
        cell.homeWeatherCellView.layer.cornerRadius = 10
        cell.homeWeatherCellView.layer.masksToBounds = true
        
        cell.homeWeatherCellView.locationLabel.text = locations[indexPath.row]
        cell.homeWeatherCellView.locationLabel.font = UIFont.boldSystemFont(ofSize: 25)
        cell.homeWeatherCellView.locationLabel.textColor = .black
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.homeView.weatherInfoCollectionView.frame.width
        let height = self.homeView.weatherInfoCollectionView.frame.height
        
        
        return CGSize(width: width-20, height: height / 4.5)
    }
}
