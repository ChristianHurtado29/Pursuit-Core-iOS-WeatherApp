//
//  WeatherCVC.swift
//  WeatherApp
//
//  Created by Christian Hurtado on 2/3/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class WeatherCVC: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hiLabel:UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    func configureCell(for data: WeatherData){
        dateLabel.text = data.time.convertDate()
        hiLabel.text = "High: \(data.temperatureHigh.description)°F"
        lowLabel.text = "Low: \(data.temperatureLow.description)°F"
        if data.temperatureHigh > 60.0 && data.temperatureHigh <= 74.9 {
            backgroundColor = .green
        } else if data.temperatureHigh > 75.0 && data.temperatureHigh <= 84.9 {
            backgroundColor = .orange
        } else if data.temperatureHigh > 85.0 {
            backgroundColor = .red
        } else if data.temperatureHigh <= 32.0 {
            backgroundColor = . blue
        } else {
            backgroundColor = .systemTeal
        }
        weatherImage.image = UIImage(named: data.icon)
    }

}
