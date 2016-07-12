//
//  UnitsTests.swift
//  WorldWeatherCore
//
//  Created by Esteban Torres on 22/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// Test
import XCTest

//// WorldWeatherCore
// Models
@testable import WorldWeatherCore

class UnitsTests: XCTestCase {
  func testDistanceMetric() {
    let unit = Unit.Metric
    XCTAssertEqual(unit.speedLetter, "Kmph")
    XCTAssertEqual(unit.speedUnit, "Kmph")
  }
  
  func testDistanceImperial() {
    let unit = Unit.Imperial
    XCTAssertEqual(unit.speedLetter, "M")
    XCTAssertEqual(unit.speedUnit, "Miles")
  }
  
  func testTemperatureMetric() {
    let unit = Unit.Metric
    XCTAssertEqual(unit.temperatureLetter, "C")
    XCTAssertEqual(unit.temperatureUnit, "Celsius")
  }
  
  func testTemperatureImperial() {
    let unit = Unit.Imperial
    XCTAssertEqual(unit.temperatureLetter, "F")
    XCTAssertEqual(unit.temperatureUnit, "Fahrenheit")
  }
  
  func testStringValues() {
    XCTAssertEqual(Unit.Imperial.rawValue, "imperial")
    XCTAssertEqual(Unit.Metric.rawValue, "metric")
    XCTAssertNotEqual(Unit.Imperial.rawValue, "Imperial")
    XCTAssertNotEqual(Unit.Metric.rawValue, "Metric")
  }
}
