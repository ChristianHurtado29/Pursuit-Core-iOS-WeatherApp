//
//  DetailedViewController.swift
//  WeatherApp
//
//  Created by Christian Hurtado on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

class FavesViewController: UIViewController {
    
    private let favesView = FavesView()
    
    var faves = [Favorites?](){
        didSet{
            DispatchQueue.main.async {
                self.favesView.favesCollection.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = favesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
        getFaves()
        favesView.favesCollection.dataSource = self
        favesView.favesCollection.delegate = self
        view.backgroundColor = .lightGray
    }
    
    
    
    func getFaves() {
        let dataPersistence = DataPersistence<Favorites>(filename: "photos")
        do {
            faves = try dataPersistence.loadItems()
        } catch {
            print("load data error")
        }
    }
}

extension FavesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return faves.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = favesView.favesCollection.dequeueReusableCell(withReuseIdentifier: "FavesCell", for: indexPath) as? FavesCellController else{
            fatalError("cant find cell")
        }
        let fave = faves[indexPath.row]
        cell.imageView.image = UIImage(data: fave!.image)
        cell.sizeThatFits(CGSize(width: 400, height: 200))
        return cell
    }
    
    
    
}



extension FavesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 374, height: 250)
    }
}
