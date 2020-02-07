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
import DataPersistence

class DetailViewController: UIViewController {
    
    var cityname: String?
    var forecast: WeatherData?
    var url: String?
    var dataPersistence = DataPersistence<Favorites>(filename: "photos")
    
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
        cityLabel.backgroundColor = .lightGray
        cityLabel.alpha = 0.7
        summaryLabel.text = forecast?.summary
        summaryLabel.backgroundColor = .lightGray
        highLabel.text = "High: \(forecast?.temperatureHigh ?? 80.0)°F"
        highLabel.backgroundColor = .lightGray
        highLabel.alpha = 0.7
        lowLabel.text = "Low: \(forecast?.temperatureLow ?? 40.0)°F"
        lowLabel.backgroundColor = .lightGray
        lowLabel.alpha = 0.7
        riseLabel.text = "Sunrise at: \(forecast?.sunriseTime.convertTime() ?? "6 am")"
        riseLabel.backgroundColor = .lightGray
        riseLabel.alpha = 0.7
        setLabel.text = "Sunset at: \(forecast?.sunsetTime.convertTime() ?? "7 pm")"
        setLabel.backgroundColor = .lightGray
        setLabel.alpha = 0.7
        windLabel.text = "Wind at: \(forecast?.windSpeed ?? 5.5) mph"
        windLabel.backgroundColor = .lightGray
        windLabel.alpha = 0.7
        precipLabel.text = "Precipitation at: \(forecast?.precipType ?? "4.3")"
        precipLabel.backgroundColor = .lightGray
        precipLabel.alpha = 0.7
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
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        if let image = imageView.image{
                if let imageData = image.jpegData(compressionQuality: 0.99){
                    do{
                        try dataPersistence.createItem(Favorites(image: imageData))
                        print("Success in saving photo")
                        let showAlert = UIAlertController(title: "Success", message: "Photo saved", preferredStyle: .alert)
                        showAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(showAlert, animated: true)
                    } catch {
                        let showAlert = UIAlertController(title: "Failed", message: "Photo saved", preferredStyle: .alert)
                        showAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(showAlert, animated: true)
                    }
                }
            }
        }
    }
    
