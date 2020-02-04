//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Christian Hurtado on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var cityname: String?
    var forecast: Data?
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var riseLabel: UILabel!
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var precipLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.text = "Weather for \(cityname ?? "Brooklyn")"
        summaryLabel.text = forecast?.summary
        highLabel.text = "High: \(forecast?.temperatureHigh ?? 80.0)°F"
        lowLabel.text = "Low: \(forecast?.temperatureLow ?? 40.0)°F"
        riseLabel.text = "Sunrise at: \(forecast?.sunriseTime ?? 6)"
        setLabel.text = "Sunset at: \(forecast?.sunsetTime ?? 7)"
        windLabel.text = "Wind at: \(forecast?.windSpeed ?? 5.5)"
        precipLabel.text = "Precipitation at: \(forecast?.precipType ?? "4.3")"
        
        

    }
    

}
