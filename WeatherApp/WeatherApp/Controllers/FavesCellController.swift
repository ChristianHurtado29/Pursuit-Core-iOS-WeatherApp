//
//  FavesCell.swift
//  WeatherApp
//
//  Created by Christian Hurtado on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit
import NetworkHelper

class FavesCellController: UICollectionViewCell {
    
    public lazy var imageView: UIImageView = {
        let image = UIImageView()

        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        constrainingImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        constrainingImageView()
    }
    
    func constrainingImageView(){
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 400),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            
        ])
    }
}

