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
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.weatherIconImageView.setImageByIconID(id: "02d")
    }
}
