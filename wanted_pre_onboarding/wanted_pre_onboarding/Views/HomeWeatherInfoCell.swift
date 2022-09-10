//
//  HomeWeatherInfoCell.swift
//  wanted_pre_onboarding
//
//  Created by 김승찬 on 2022/09/03.
//

import UIKit

public class HomeWeatherInfoCell: UICollectionViewCell {
    @IBOutlet var homeWeatherCellView: HomeWeatherCellView!
}

public class HomeWeatherCellView: UIView {
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var weatherIconImageView: UIImageView!
    @IBOutlet var thermometerIconImageView: UIImageView!
    @IBOutlet var humidityIconImageView: UIImageView!
}
