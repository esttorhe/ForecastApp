//
//  WeatherConditionDetails.swift
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

extension WeatherConditionDetails: Mappable {
  public init(map: Mapper) throws {
    let error = NSError(domain: "es.estebantorr.WorldWeatherMapping",
                        code: -999,
                        userInfo: [
                          NSLocalizedDescriptionKey: NSLocalizedString("Empty method. Added only to adhere to `Mappable`", comment: "Empty method. Added only to adhere to `Mappable`")
      ])
    
    throw error
  }
  
  public init(map: Mapper, withUnit unit: Unit) throws {
    self.unit = unit
    if let temp = map.optionalFrom("temp\(self.unit.temperatureLetter)", transformation: extractFloat) {
      self.temperature = temp
    } else if let temp = map.optionalFrom("temp_\(self.unit.temperatureLetter)", transformation: extractFloat) {
      self.temperature = temp
    } else {
      throw MapperError.ConvertibleError(value: "temperature", type: Float.Type.self)
    }
    
    self.windspeed = try map.from("windspeed\(self.unit.speedUnit)", transformation: extractFloat)
    self.heatIndex = map.optionalFrom("HeatIndex\(self.unit.temperatureLetter)", transformation: extractFloat)
    self.dewPoint = map.optionalFrom("DewPoint\(self.unit.temperatureLetter)", transformation: extractFloat)
    self.windChill = map.optionalFrom("WindChill\(self.unit.temperatureLetter)", transformation: extractFloat)
    self.windGust = map.optionalFrom("WindGust\(self.unit.speedUnit)", transformation: extractFloat)
    self.feelsLike = try map.from("FeelsLike\(self.unit.temperatureLetter)", transformation: extractFloat)
  }
  
  @warn_unused_result
  public static func from(JSON: NSDictionary, withUnit unit: Unit) -> WeatherConditionDetails? {
    return try? self.init(map: Mapper(JSON: JSON), withUnit: unit)
  }
}