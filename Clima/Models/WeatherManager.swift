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
    
    func fetchWeather(city: String){
        let urlString = "\(weatherURL)&q=\(city)"
        performRequest(for: urlString)
    }
    
    func performRequest(for urlString: String){
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    return
                }
                
                if let safeData = data {
                    self.parseJson(weatherData: safeData)
                    
                }
            }
            task.resume()
        }
        
    }
    
    func parseJson(weatherData: Data){
        
    }
    
    
    
}
