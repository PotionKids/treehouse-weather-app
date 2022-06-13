//
//  ViewController.swift
//  Stormy
//
//  Created by Pasan Premaratne on 5/12/15.
//  Copyright (c) 2015 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var currentHumidityLabel: UILabel?
    @IBOutlet weak var currentPrecipitationLabel: UILabel?
    @IBOutlet weak var currentWeatherIcon: UIImageView?
    @IBOutlet weak var currentWeatherSummary: UILabel?
    @IBOutlet weak var refreshButton: UIButton?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    // Location coordinates
    let coordinate: (lat: Double, lon: Double) = (37.8267,-122.423)
    
    // TODO: Enter your API key here
    private let forecastAPIKey = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        retrieveWeatherForecast()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrieveWeatherForecast() {
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(lat: coordinate.lat, lon: coordinate.lon)
        {
            (currently) in
            
            if let currentWeather = currently
            {
                
            DispatchQueue.main.async
                {
                    if let temperature = currentWeather.temperature
                    {
                        self.currentTemperatureLabel?.text = "\(temperature)º"
                    }
                    
                    if let humidity = currentWeather.humidity
                    {
                        self.currentHumidityLabel?.text = "\(humidity)%"
                    }
                    
                    if let precipitation = currentWeather.precipProbability
                    {
                        self.currentPrecipitationLabel?.text = "\(precipitation)%"
                    }
                    
                    if let icon = currentWeather.icon
                    {
                        self.currentWeatherIcon?.image = icon
                    }
                    
                    if let summary = currentWeather.summary
                    {
                        self.currentWeatherSummary?.text = summary
                    }
                    
                    self.toggleRefreshAnimation(on: false)
                }
            }
        }
    }
    
    @IBAction func refreshWeather() {
        toggleRefreshAnimation(on: true)
        retrieveWeatherForecast()
    }
    
    func toggleRefreshAnimation(on: Bool) {
        refreshButton?.isHidden = on
        if on {
            activityIndicator?.startAnimating()
        } else {
            activityIndicator?.stopAnimating()
        }
    }
}

