//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var zipcodeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var zipTextField: UITextField!
    
    @IBOutlet weak var backgroundImgView: UIImageView!
    
    
    var cityName = ""
    
    private var zipCode = String() {
        didSet {
            getCoords(zipCode)
            print(zipCode)
        }
    }
    
    var weekForecasts = [Data](){
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.text = "Forecast for: "
        zipcodeLabel.text = "Please enter your zipcode"
        collectionView.dataSource = self
        zipTextField.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailedVC = segue.destination as? DetailViewController, let indexPath = collectionView.indexPathsForSelectedItems?.first else {
            fatalError("Could not segue Country")
        }
        detailedVC.cityname = cityName
        detailedVC.forecast = weekForecasts[indexPath.row]
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        if weekForecasts.first?.temperatureHigh ?? 65.0 > 80.0 {
//            backgroundImgView.image = UIImage(named: "beach")
//        } else if weekForecasts.first!.temperatureHigh ?? 65.0 < 32 {
//            backgroundImgView.image = UIImage(named: "cold")
//        } else {
//            backgroundImgView.image = UIImage(named: "spring")
//        }
//    }
    
    public func getCoords(_ zip: String){
        ZipCodeHelper.getLatLongName(fromZipCode: zip) { [weak self] (result) in
            switch result{
            case .failure(let zipError):
                print("get error: \(zipError)")
            case .success(let coordinates):
                self?.getForecasts(lat: coordinates.lat, long: coordinates.long)
                self?.cityLabel.text = "Weather for \(coordinates.placeName)"
                self?.cityName = coordinates.placeName
                print("this is the \(coordinates) information")
            }
        }
    }
       public func getForecasts(lat: Double, long: Double) {
            WeatherAPI.getForecast(lat: lat, long: long) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("get weather error: \(appError)")
            case .success(let dailyForecast):
                print("success")
                self?.weekForecasts = dailyForecast
                dump(dailyForecast)
            }
        }
    }
}
            

extension MainViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weekForecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCVC else {
            fatalError("Could not type cast reusable cell")
        }
        let forecast = weekForecasts[indexPath.row]
        cell.configureCell(for: forecast)
                return cell
    }
    
}

extension MainViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        zipCode = textField.text ?? "11230"
        zipTextField.resignFirstResponder()
        return true
    }
}
