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
    
    var cityName = ""
    
    private var zipCode = String() {
        didSet {
            getCoords(zipCode)
        }
    }
    
    var weekForecasts = [Daily](){
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
    
    public func getCoords(_ zip: String){
        ZipCodeHelper.getLatLongName(fromZipCode: zip) { [weak self] (result) in
            switch result{
            case .failure(let zipError):
                print("get error: \(zipError)")
            case .success(let coordinates):
                self?.getForecasts(lat: coordinates.lat, long: coordinates.long)
                self?.cityLabel.text = "Weather for \(coordinates.placeName)"
                print(coordinates)
            }
        }
    }
       public func getForecasts(lat: Double, long: Double) {
            WeatherAPI.getForecast(lat: lat, long: long) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("getWeather error: \(appError)")
            case .success(let dailyForecast):
                print("success")
                self?.weekForecasts = dailyForecast
                }
            }
    
    //    func getName(for zip: String) {
    //        ZipCodeHelper.getLatLongName(fromZipCode: zip, completionHandler: {[weak self] (result) in
    //        switch result {
    //        case .failure( let appError ):
    //            print("Error \(appError)")
    //        case .success( let name):
    //            self?.cityName = name
    //           dump(name)
    //            }
    //        })
    //    }
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
        cell.dateLabel.text = weekForecasts.first?.data.first?.time.description
        cell.hiLabel.text = "High: \(weekForecasts.first?.data.first?.temperatureHigh.description)"
        cell.lowLabel.text = "Low: \(weekForecasts.first?.data.first?.temperatureLow.description)"
        
        cell.backgroundColor = .gray
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
