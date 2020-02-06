//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit


class MainViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var zipcodeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var zipTextField: UITextField!
    
    @IBOutlet weak var backgroundImgView: UIImageView!
    
    
    var cityName = String() {
        didSet {
        }
    }
    
    private var zipCode = String() {
        didSet {
            getCoords(zipCode)
            print(zipCode)
        }
    }
    
    var weekForecasts = [WeatherData](){
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var photos = [Pictures](){
        didSet {
            DispatchQueue.main.async {
                self.backgroundImgView.getImage(with: self.photos.first?.largeImageURL ?? "flowers", completion: { (result) in
                    switch result {
                    case .failure:
                        DispatchQueue.main.async {
                            self.backgroundImgView.image = UIImage(named: "flowers")
                        }
                    case .success(let image):
                        DispatchQueue.main.async {
                            self.backgroundImgView.image = image
                        }
                    }
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .gray
        collectionView.alpha = CGFloat(0.7)
        cityLabel.text = ""
        cityLabel.backgroundColor = .lightGray
        cityLabel.alpha = 0.7
        zipcodeLabel.text = "Please enter your zipcode"
        zipcodeLabel.backgroundColor = .lightGray
        zipcodeLabel.alpha = CGFloat(0.79)
        collectionView.dataSource = self
        zipTextField.delegate = self
        backgroundImgView.image = #imageLiteral(resourceName: "weatherBack")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        //     backgroundImg()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailedVC = segue.destination as? DetailViewController, let indexPath = collectionView.indexPathsForSelectedItems?.first else {
            fatalError("Could not segue Country")
        }
        detailedVC.cityname = cityName
        detailedVC.forecast = weekForecasts[indexPath.row]
    }
    
    
    public func getCoords(_ zip: String){
        ZipCodeHelper.getLatLongName(fromZipCode: zip) { [weak self] (result) in
            switch result{
            case .failure(let zipError):
                print("get error: \(zipError)")
            case .success(let coordinates):
                self?.getForecasts(lat: coordinates.lat , long: coordinates.long)
                self?.cityLabel.text = "This week in \(coordinates.placeName)"
                self?.cityName = coordinates.placeName
                DispatchQueue.main.async {
                    self?.getPhotos(for: coordinates.placeName)
                    self?.cityName = coordinates.placeName
                }
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
    
    func getPhotos(for search: String){
        PicturesAPI.loadPictures(for: search) { (result) in
            switch result {
            case .failure(let appError):
                print("error \(appError)")
            case .success(let pictures):
                print("Success")
                self.photos = pictures
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
