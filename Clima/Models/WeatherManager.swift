    //
    //  WeatherManager.swift
    //  Clima
    //
    //  Created by Abdulrahman on 3/5/22.
    //

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager{
    
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=" + apiKey + "&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
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
                    if let weather = self.parseJson(weatherData: safeData){
                        delegate?.didUpdateWeather(weather: weather)
                    }
                    
                }
            }
            task.resume()
        }
        
    }
    
    func parseJson(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            print(error)
            return nil
        }
    }
    }
