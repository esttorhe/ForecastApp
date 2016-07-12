//
//  Weather.swift
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

extension Weather: Mappable {
  public init(map: Mapper) throws {
    self.date = try map.from("date", transformation: extractDate)
    self.maxTemperatureCelsius = try map.from("maxtempC", transformation: extractFloat)
    self.maxTemperatureFahrenheit = try map.from("maxtempF", transformation: extractFloat)
    self.minTemperatureCelsius = try map.from("mintempC", transformation: extractFloat)
    self.minTemperatureFahrenheit = try map.from("mintempF", transformation: extractFloat)
    self.uvIndex = try map.from("uvIndex", transformation: extractInt)
    self.hourly = try map.from("hourly")
  }
}