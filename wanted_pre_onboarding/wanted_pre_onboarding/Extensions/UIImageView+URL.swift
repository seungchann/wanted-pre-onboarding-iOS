//
//  UIImageView+URL.swift
//  wanted_pre_onboarding
//
//  Created by 김승찬 on 2022/09/10.
//

import UIKit

extension UIImageView {
    func setImageByIconID(id: String) {
        let cacheKey = NSString(string: id)
        
        // 해당 Key 에 이미지가 저장되어 있을 경우 사용
        if let cacheImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            self.image = cacheImage
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: "https://openweathermap.org/img/wn/\(id)@2x.png") {
                URLSession.shared.dataTask(with: url) { data, responce, error in
                    if let _ = error {
                        DispatchQueue.main.async {
                            self.image = UIImage()
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        if let data = data, let image = UIImage(data: data) {
                            self.image = image
                        }
                    }
                }.resume()
            }
        }
    }
}
