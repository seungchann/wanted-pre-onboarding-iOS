//
//  UIImageView+URL.swift
//  wanted_pre_onboarding
//
//  Created by 김승찬 on 2022/09/10.
//

import UIKit

extension UIImageView {
    func load(id: String) {
        let url = URL(string: "https://openweathermap.org/img/wn/\(id)@2x.png")
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
