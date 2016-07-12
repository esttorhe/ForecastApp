//
//  Forecast.swift
//  WorldWeatherCore
//
//  Created by Esteban Torres on 23/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// Foundation
import Foundation

public struct Forecast {
  public let cityName: String
  public let currentCondition: WeatherCondition
  public let weather: [Weather]
}