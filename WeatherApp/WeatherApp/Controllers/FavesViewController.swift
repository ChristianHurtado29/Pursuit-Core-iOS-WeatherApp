//
//  DetailedViewController.swift
//  WeatherApp
//
//  Created by Christian Hurtado on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavesViewController: UIViewController {
    
    
    private let favesView = FavesView()
    
    
    var faves = [Pictures?](){
        didSet{
            DispatchQueue.main.async {
                
            }
        }
    }
    
    override func loadView() {
        view = favesView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
        favesView.favesCollection.dataSource = self
    }
    
}

extension FavesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        faves.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favesView.favesCollection.dequeueReusableCell(withReuseIdentifier: "FavesCell", for: indexPath) as? FavesCellController
        let fave = faves[indexPath.row]
//        cell?.configureCell(for: fave)
        return cell!
    }
    
    

}
