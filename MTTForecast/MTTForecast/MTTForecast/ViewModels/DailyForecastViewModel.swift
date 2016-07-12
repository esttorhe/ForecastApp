//
//  DailyForecastViewModel.swift
//  MTTForecast
//
//  Created by Esteban Torres on 24/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// Foundation
import Foundation

//// WorldWeather
// Models
import WorldWeatherCore

final class DailyForecastViewModel {
  // MARK: Properties
  private let unit: Unit
  private let weather: Weather!
  var maxTemperature: String {
    get {
      let temperature = self.unit == .Metric ? self.weather.maxTemperatureCelsius : self.weather.maxTemperatureFahrenheit
      return "\(temperature) \(self.unit.temperatureLetter)"
    }
  }
  
  var minTemperature: String {
    get {
      let temperature = self.unit == .Metric ? self.weather.minTemperatureCelsius : self.weather.minTemperatureFahrenheit
      return "\(temperature) \(self.unit.temperatureLetter)"
    }
  }
  
  var date: String {
    get {
      let dfKey = "dailyForecastDateFormatter"
      let dateFormatter: NSDateFormatter
      if let df = NSThread.mainThread().threadDictionary[dfKey] as? NSDateFormatter {
        dateFormatter = df
      } else {
        dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        NSThread.mainThread().threadDictionary[dfKey] = dateFormatter
      }
      
      return dateFormatter.stringFromDate(self.weather.date)
    }
  }
  
  init(weather: Weather, unit: Unit = .Metric) {
    self.weather = weather
    self.unit = unit
  }
}