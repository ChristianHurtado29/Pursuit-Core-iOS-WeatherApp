//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Christian Hurtado on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit
import NetworkHelper

class DetailViewController: UIViewController {
    
    var cityname: String?
    var forecast: Data?
    var url: String?
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var riseLabel: UILabel!
    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var precipLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.text = "Weather for \(cityname ?? "Brooklyn")"
        summaryLabel.text = forecast?.summary
        summaryLabel.backgroundColor = .lightGray
        highLabel.text = "High: \(forecast?.temperatureHigh ?? 80.0)°F"
        lowLabel.text = "Low: \(forecast?.temperatureLow ?? 40.0)°F"
        riseLabel.text = "Sunrise at: \(forecast?.sunriseTime.convertTime() ?? "6 am")"
        setLabel.text = "Sunset at: \(forecast?.sunsetTime.convertTime() ?? "7 pm")"
        windLabel.text = "Wind at: \(forecast?.windSpeed ?? 5.5) mph"
        precipLabel.text = "Precipitation at: \(forecast?.precipType ?? "4.3")"
        backgroundImageView.image = UIImage(named: cityname ?? "weather")
        
        PicturesAPI.loadPictures(for: cityname ?? "New York") { (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            case .success(let Pictures):
                DispatchQueue.main.async {
                    self.imageView.getImage(with: Pictures.first!.largeImageURL) { (result) in
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
        }
      
    }
}
