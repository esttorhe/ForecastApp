//
//  CityForecastViewModel.swift
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

// DataControllers
import WorldWeatherAPI

final class CityForecastViewModel {
  // Error
  struct CityForecastError: ErrorType {
    enum CityForecastErrorType {
      case NetworkError
      case InvalidCity
    }
    
    /**
     Error type
     
     - seealso: `ForecastErrorType`
     */
    let errorType: CityForecastErrorType
    
    /// Detailed description of the error.
    let description: String?
    
    /// The internal/parent error.
    let internalError: ErrorType?
  }
  
  // MARK: Properties
  private var unit: Unit = .Metric
  private var offlineModeOn: Bool = false
  private var forecast: Forecast?=nil {
    didSet {
      if let forecast = forecast {
        self.dailyForecasts = forecast.weather.map { DailyForecastViewModel(weather: $0, unit: self.unit) }
      }
    }
  }
  var dailyForecasts: [DailyForecastViewModel] = []
  
  private var conditionDetails: WeatherConditionDetails {
    get {
      return (self.unit == .Metric ? self.forecast?.currentCondition.detailsMetric : self.forecast?.currentCondition.detailsImperial)!
    }
  }
  
  let cityName: String
  
  var currentTemperature: String {
    get {
      return "\(self.conditionDetails.temperature) \(self.unit.temperatureLetter)"
    }
  }
  
  var currentWeatherIconURL: NSURL? {
    get {
      return self.forecast?.currentCondition.weatherIconUrl
    }
  }
  
  var currentWeatherDescription: String {
    get {
      return self.forecast?.currentCondition.weatherDesc ?? "N/A"
    }
  }
  
  var currentTemperatureFeelsLike: String {
    get {
      return "\(self.conditionDetails.feelsLike) \(self.unit.temperatureLetter)"
    }
  }

  var numberOfDailyForecasts: Int {
    get {
      return self.dailyForecasts.count
    }
  }
  
  init(city: String, unit: Unit, offlineModeOn: Bool = false) {
    self.unit = unit
    self.cityName = city
    self.offlineModeOn = offlineModeOn
  }
  
  // MARK: - Public Methods
  func fiveDayForecast(completion:(success: Bool, error: ErrorType?) -> Void) -> Void {
    ForecastDataController.retrieveForecastForCity(cityName, forFollowingDays: 5, offlineModeOn: offlineModeOn) { [unowned self] (forecast: Forecast?, error: ErrorType?) in
      if let error = error {
        let internalError = CityForecastError(errorType: .NetworkError,
                                              description: "WorldWeatherAPI couldn't resolve the forecast for the requested city: \(self.cityName)",
                                              internalError: error)
        completion(success: false, error: internalError)
      } else if let forecast = forecast {
        self.forecast = forecast
        completion(success: true, error: nil)
      } else {
        let internalError = CityForecastError(errorType: .InvalidCity,
                                              description: "The provided city: «\(self.cityName)» is either invalid or not available in the WorldWeatherAPI database.",
                                              internalError: nil)
        completion(success: false, error: internalError)
      }
    }
  }
  
  func dailyForecastViewModelAtIndex(index: Int) -> DailyForecastViewModel {
    assert(index < self.dailyForecasts.count, "Index out of bounds.")
    let dailyForecast = self.dailyForecasts[index]
    
    return dailyForecast
  }
}