//
//  WeatherCondition.swift
//  WorldWeatherCore
//
//  Created by Esteban Torres on 22/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// Foundation
import Foundation

public struct WeatherCondition {
  public let time: Int?
  public let observationTime: NSDate?
  public let windDirectionDegree: Int
  public let windDirection16Point: String
  public let weatherCode: Int
  public let weatherIconUrl: NSURL?
  public let weatherDesc: String
  public let precipationMM: Float
  public let humidity: Float
  public let visibility: Int
  public let pressure: Float
  public let cloudcover: Float
  public let chanceOfRain: Float?
  public let chanceOfRemdry: Float?
  public let chanceOfWindy: Float?
  public let chanceOfOvercast: Float?
  public let chanceOfSunshine: Float?
  public let chanceOfFrost: Float?
  public let chanceOfHighTemp: Float?
  public let chanceOfFog: Float?
  public let chanceOfSnow: Float?
  public let chanceOfThunder: Float?
  public let detailsMetric: WeatherConditionDetails
  public let detailsImperial: WeatherConditionDetails
}