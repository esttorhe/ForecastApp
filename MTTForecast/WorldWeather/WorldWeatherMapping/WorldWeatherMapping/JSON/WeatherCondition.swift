//
//  WeatherCondition.swift
//  WorldWeatherMapping
//
//  Created by Esteban Torres on 22/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// Foundation
import Foundation

//// «Local» Dependencies
// Models
import WorldWeatherCore

//// Pods
import Mapper

extension WeatherCondition: Mappable {
  public init(map: Mapper) throws {
    self.observationTime = map.optionalFrom("observation_time", transformation: extractTime)
    self.time = map.optionalFrom("time", transformation: extractInt)
    self.windDirectionDegree = try map.from("winddirDegree", transformation: extractInt)
    self.windDirection16Point = try map.from("winddir16Point")
    self.weatherCode = try map.from("weatherCode", transformation: extractInt)
    if let weatherIconUrlArray: [[String: AnyObject]] = map.optionalFrom("weatherIconUrl"),
      let value = weatherIconUrlArray.first?["value"] as? String
      where weatherIconUrlArray.count > 0 {
      self.weatherIconUrl = NSURL(string: value)
    } else {
      self.weatherIconUrl = nil
    }
    
    if let weatherDescArray: [[String: AnyObject]] = map.optionalFrom("weatherDesc"),
      let value = weatherDescArray.first?["value"] as? String
      where weatherDescArray.count > 0 {
      self.weatherDesc = value
    } else {
      self.weatherDesc = "N/A"
    }
    self.precipationMM = try map.from("precipMM", transformation: extractFloat)
    self.humidity = try map.from("humidity", transformation: extractFloat)
    self.visibility = try map.from("visibility", transformation: extractInt)
    self.pressure = try map.from("pressure", transformation: extractFloat)
    self.cloudcover = try map.from("cloudcover", transformation: extractFloat)
    self.chanceOfRain = map.optionalFrom("chanceofrain", transformation: extractFloat)
    self.chanceOfRemdry = map.optionalFrom("chanceofremdry", transformation: extractFloat)
    self.chanceOfWindy = map.optionalFrom("chanceofwindy", transformation: extractFloat)
    self.chanceOfOvercast = map.optionalFrom("chanceofovercast", transformation: extractFloat)
    self.chanceOfSunshine = map.optionalFrom("chanceofsunshine", transformation: extractFloat)
    self.chanceOfFrost = map.optionalFrom("chanceoffrost", transformation: extractFloat)
    self.chanceOfHighTemp = map.optionalFrom("chanceofhightemp", transformation: extractFloat)
    self.chanceOfFog = map.optionalFrom("chanceoffog", transformation: extractFloat)
    self.chanceOfSnow = map.optionalFrom("chanceofsnow", transformation: extractFloat)
    self.chanceOfThunder = map.optionalFrom("chanceofthunder", transformation: extractFloat)
    self.detailsMetric = try WeatherConditionDetails(map: map, withUnit: .Metric)
    self.detailsImperial = try WeatherConditionDetails(map: map, withUnit: .Imperial)
  }
}