//
//  WeatherConditionTests.swift
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

class WeatherConditionTests: XCTestCase {
  func testInitializastion() {
    let detailsMetric = WeatherConditionDetails(unit: .Metric,
                                                temperature: 0.1,
                                                windspeed: 0.2,
                                                heatIndex: 0.3,
                                                dewPoint: 0.4,
                                                windChill: 0.5,
                                                windGust: 0.6,
                                                feelsLike: 0.7)
    
    let detailsImperial = WeatherConditionDetails(unit: .Imperial,
                                                  temperature: 0.1,
                                                  windspeed: 0.2,
                                                  heatIndex: 0.3,
                                                  dewPoint: 0.4,
                                                  windChill: 0.5,
                                                  windGust: 0.6,
                                                  feelsLike: 0.7)
    XCTAssertNotEqual(detailsMetric.unit, detailsImperial.unit)
    
    let condition = WeatherCondition(time: 300,
                                     observationTime: nil,
                                     windDirectionDegree: 276,
                                     windDirection16Point: "W",
                                     weatherCode: 356,
                                     weatherIconUrl: NSURL(string: "http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0010_heavy_rain_showers.png"),
                                     weatherDesc: "Moderate or heavy rain shower",
                                     precipationMM: 4.6,
                                     humidity: 84,
                                     visibility: 7,
                                     pressure: 1013,
                                     cloudcover: 34,
                                     chanceOfRain: 90,
                                     chanceOfRemdry: 0,
                                     chanceOfWindy: 0,
                                     chanceOfOvercast: 0,
                                     chanceOfSunshine: 46,
                                     chanceOfFrost: 0,
                                     chanceOfHighTemp: 0,
                                     chanceOfFog: 0,
                                     chanceOfSnow: 0,
                                     chanceOfThunder: 84,
                                     detailsMetric: detailsMetric,
                                     detailsImperial: detailsImperial)
    XCTAssertNil(condition.observationTime)
    XCTAssertEqual(condition.time, 300)
    XCTAssertEqual(condition.windDirectionDegree, 276)
    XCTAssertEqual(condition.windDirection16Point, "W")
    XCTAssertEqual(condition.weatherCode, 356)
    XCTAssertNotNil(condition.weatherIconUrl)
    XCTAssertEqual(condition.weatherIconUrl?.absoluteString, "http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0010_heavy_rain_showers.png")
    XCTAssertEqual(condition.weatherDesc, "Moderate or heavy rain shower")
    XCTAssertEqual(condition.precipationMM, 4.6)
    XCTAssertEqual(condition.humidity, 84)
    XCTAssertEqual(condition.visibility, 7)
    XCTAssertEqual(condition.pressure, 1013)
    XCTAssertEqual(condition.cloudcover, 34)
    XCTAssertEqual(condition.chanceOfRain, 90)
    XCTAssertEqual(condition.chanceOfRemdry, 0)
    XCTAssertEqual(condition.chanceOfWindy, 0)
    XCTAssertEqual(condition.chanceOfOvercast, 0)
    XCTAssertEqual(condition.chanceOfSunshine, 46)
    XCTAssertEqual(condition.chanceOfFrost, 0)
    XCTAssertEqual(condition.chanceOfHighTemp, 0)
    XCTAssertEqual(condition.chanceOfFog, 0)
    XCTAssertEqual(condition.chanceOfSnow, 0)
    XCTAssertEqual(condition.chanceOfThunder, 84)
    XCTAssertEqual(condition.detailsMetric.unit, detailsMetric.unit)
    XCTAssertEqual(condition.detailsImperial.unit, detailsImperial.unit)
  }
}