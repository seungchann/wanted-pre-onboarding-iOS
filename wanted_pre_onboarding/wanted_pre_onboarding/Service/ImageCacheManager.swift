//
//  ImageCacheManager.swift
//  wanted_pre_onboarding
//
//  Created by 김승찬 on 2022/09/10.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() { }
}
