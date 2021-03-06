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
        let constrainedVC = UIStoryboard(name: "Main", bundle: nil)
        
        guard let VC = constrainedVC.instantiateViewController(identifier: "MainViewController") as? MainViewController else {
                fatalError("could not load this")
            }
            VC.tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "1.circle"), tag: 0)
            return VC
        }()
    
    private lazy var favesViewController: FavesViewController = {
        let VC = FavesViewController()
        VC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "2.circle"), tag: 1)
        return VC
    }()
    
   override func viewDidLoad() {
        super.viewDidLoad()
        loadTabBar()
    }
    
    private func loadTabBar() {
        viewControllers = [UINavigationController(rootViewController:mainViewController), favesViewController]
    }
    
}
