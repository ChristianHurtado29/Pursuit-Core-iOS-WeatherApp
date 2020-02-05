//
//  FavesView.swift
//  WeatherApp
//
//  Created by Christian Hurtado on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavesView: UIView {
    
    public lazy var favesCollection: UICollectionView = {
        let collectionView = UICollectionView()
        return collectionView
    }()
    
    
    private func commoninit(){
        // 1.
        addSubview(favesCollection)
        // 2.
        favesCollection.translatesAutoresizingMaskIntoConstraints = false
        // 3.
        NSLayoutConstraint.activate([
            favesCollection.centerXAnchor.constraint(equalTo: centerXAnchor),
            favesCollection.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }



}
