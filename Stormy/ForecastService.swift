//
//  ForecastService.swift
//  Stormy
//
//  Created by Pasan Premaratne on 5/13/15.
//  Copyright (c) 2015 Treehouse. All rights reserved.
//

import Foundation

struct ForecastService {
    
    let forecastAPIKey: String
    let forecastBaseURL: NSURL?
    
    init(APIKey: String) {
        forecastAPIKey = APIKey
        forecastBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
    }
    
    func getForecast(lat: Double, lon: Double, completion: @escaping ((CurrentWeather?) -> Void)) {
        
        if let forecastURL = NSURL(string: "\(lat),\(lon)", relativeTo: forecastBaseURL as URL?) {
            let networkOperation = NetworkOperation(url: forecastURL)
            
            networkOperation.downloadJSONFromURL {
                (JSONDictionary) in
                let currentWeather = self.currentWeatherFromJSONDictionary(jsonDictionary: JSONDictionary)
                completion(currentWeather)
            }
        } else {
            print("Could not construct a valid URL")
        }
    }
    
    func currentWeatherFromJSONDictionary(jsonDictionary: [String: AnyObject]?) -> CurrentWeather? {
        if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String: AnyObject] {
            return CurrentWeather(weatherDictionary: currentWeatherDictionary)
        } else {
            print("JSON dictionary returned nil for currently key")
            return nil
        }
    }
    
}
