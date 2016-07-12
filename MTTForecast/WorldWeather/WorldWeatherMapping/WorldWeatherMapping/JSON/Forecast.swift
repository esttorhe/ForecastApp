//
//  Forecast.swift
//  WorldWeatherMapping
//
//  Created by Esteban Torres on 23/6/16.
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

extension Forecast: Mappable {
  @warn_unused_result
  public init(map: Mapper) throws {
    let conditionArray: [WeatherCondition] = try map.from("current_condition")
    guard let currentCondition = conditionArray.first else {
      throw MapperError.InvalidRawValueError(field: "current_condition", value: conditionArray, type: WeatherCondition.Type.self)
    }
    
    let request: [[String: String]] = try map.from("request")
    let first = request.first
    self.cityName = first?["query"] ?? "N/A"
    self.currentCondition = currentCondition
    self.weather = try map.from("weather")
  }
  
  @warn_unused_result
  public static func from(JSON: NSDictionary) -> Forecast? {
    return try? self.init(map: Mapper(JSON: JSON))
  }
}