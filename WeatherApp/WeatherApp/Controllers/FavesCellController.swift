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
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(for cityName: String){
        imageView.getImage(with: cityName) { (result) in
        switch result {
        case .failure:
            DispatchQueue.main.async {
                self.imageView.image = UIImage(systemName: "exclaimationmark-triangle")
                print("failed image")
            }
        case .success(let image):
            DispatchQueue.main.async {
                self.imageView.image = image
                print("success image")
            }
        }
    }
}
}
