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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(FavesCellController.self, forCellWithReuseIdentifier: "FavesCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commoninit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commoninit()
    }
    
    private func commoninit(){
        // 1.
        addSubview(favesCollection)
        // 2.
        favesCollection.translatesAutoresizingMaskIntoConstraints = false
        // 3.
        NSLayoutConstraint.activate([
            favesCollection.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            favesCollection.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            favesCollection.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            favesCollection.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
    }



}
