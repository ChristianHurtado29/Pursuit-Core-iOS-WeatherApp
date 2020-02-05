//
//  WeatherTabController.swift
//  WeatherApp
//
//  Created by Christian Hurtado on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class WeatherTabController: UITabBarController {
    
    private lazy var mainViewController: MainViewController = {
        let VC = MainViewController()
        VC.tabBarItem = UITabBarItem(title: "Weather", image: UIImage(systemName: "1.circle"), tag: 0)
        return VC
    }()
    
    private lazy var detailedViewController: FavesViewController = {
        let VC = FavesViewController()
        VC.tabBarItem = UITabBarItem(title: "Detail", image: UIImage(systemName: "2.heart"), tag: 1)
        return VC
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
    
    
}
