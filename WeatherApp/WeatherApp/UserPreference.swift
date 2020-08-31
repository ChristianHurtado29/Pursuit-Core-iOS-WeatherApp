//
//  UserPreferences.swift
//  WeatherApp
//
//  Created by Christian Hurtado on 8/30/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation


struct UserPreferenceKey {
    static let zipCode = "ZipCode"
}

class UserPreference {
    
    // a Singleton's initializer NEEDS to be private - this ensures that ONLY one instance of this class is used throughout the application
    private init() {}
    
    private let standard = UserDefaults.standard
    
    static let shared = UserPreference()
    
    func updateZipCode(with zip: Int){
        standard.set(zip, forKey: UserPreferenceKey.zipCode)
    }
    
    func getZipCode() -> Int? {
        guard let zipCode = standard.object(forKey: UserPreferenceKey.zipCode) as? Int else {
            return nil
        }
        return zipCode
    }
}
