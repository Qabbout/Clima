//
//  WeatherManager.swift
//  Clima
//
//  Created by Abdulrahman on 3/5/22.
//

import Foundation


struct WeatherManager{
    
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=" + apiKey + "&units=metric"
        
    
    
}
