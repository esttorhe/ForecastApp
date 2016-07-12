//
//  WeatherConditionDetails.swift
//  WorldWeatherCore
//
//  Created by Esteban Torres on 22/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// Foundation
import Foundation

public struct WeatherConditionDetails {
  public let unit: Unit
  public let temperature: Float
  public let windspeed: Float
  public let heatIndex: Float?
  public let dewPoint: Float?
  public let windChill: Float?
  public let windGust: Float?
  public let feelsLike: Float
}