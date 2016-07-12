//
//  Weather.swift
//  WorldWeatherCore
//
//  Created by Esteban Torres on 23/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// Foundation
import Foundation

public struct Weather {
  public let date: NSDate
  public let maxTemperatureCelsius: Float
  public let maxTemperatureFahrenheit: Float
  public let minTemperatureCelsius: Float
  public let minTemperatureFahrenheit: Float
  public let uvIndex: Int
  public let hourly: [WeatherCondition]
  
  public init(date: NSDate,
              maxTemperatureCelsius: Float,
              maxTemperatureFahrenheit: Float,
              minTemperatureCelsius: Float,
              minTemperatureFahrenheit: Float,
              uvIndex: Int,
              hourly: [WeatherCondition]) {
    self.date                     = date
    self.maxTemperatureCelsius    = maxTemperatureCelsius
    self.maxTemperatureFahrenheit = maxTemperatureFahrenheit
    self.minTemperatureCelsius    = minTemperatureCelsius
    self.minTemperatureFahrenheit = minTemperatureFahrenheit
    self.uvIndex                  = uvIndex
    self.hourly                   = hourly
  }
}