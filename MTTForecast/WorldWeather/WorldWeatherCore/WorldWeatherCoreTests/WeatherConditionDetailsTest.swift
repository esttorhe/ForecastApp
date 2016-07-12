//
//  WeatherConditionDetailsTest.swift
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

class WeatherConditionDetailsTest: XCTestCase {
  func testConditionDetailsInitialization() {
    let details = WeatherConditionDetails(unit: .Metric,
                                          temperature: 0.1,
                                          windspeed: 0.2,
                                          heatIndex: 0.3,
                                          dewPoint: 0.4,
                                          windChill: 0.5,
                                          windGust: 0.6,
                                          feelsLike: 0.7)
    XCTAssertEqual(details.unit, Unit.Metric)
    XCTAssertEqual(details.temperature, 0.1)
    XCTAssertEqual(details.windspeed, 0.2)
    XCTAssertEqual(details.heatIndex, 0.3)
    XCTAssertEqual(details.dewPoint, 0.4)
    XCTAssertEqual(details.windChill, 0.5)
    XCTAssertEqual(details.windGust, 0.6)
    XCTAssertEqual(details.feelsLike, 0.7)
  }
}
