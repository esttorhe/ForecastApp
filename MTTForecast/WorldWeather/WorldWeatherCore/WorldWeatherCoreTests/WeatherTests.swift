//
//  WeatherTests.swift
//  WorldWeatherCore
//
//  Created by Esteban Torres on 23/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// Test
import XCTest

//// WorldWeatherCore
// Models
@testable import WorldWeatherCore

class WeatherTests: XCTest {
  func testWeatherInitialization() {
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
    
    let date = NSDate()
    let weather = Weather(date: date,
                          maxTemperatureCelsius: 24,
                          maxTemperatureFahrenheit: 75,
                          minTemperatureCelsius: 14,
                          minTemperatureFahrenheit: 58,
                          uvIndex: 7,
                          hourly: [condition])
    XCTAssertNotNil(weather)
    XCTAssertEqual(date, weather.date)
    XCTAssertEqual(weather.maxTemperatureCelsius, 24)
    XCTAssertEqual(weather.maxTemperatureFahrenheit, 75)
    XCTAssertEqual(weather.minTemperatureCelsius, 14)
    XCTAssertEqual(weather.minTemperatureFahrenheit, 58)
    XCTAssertEqual(weather.uvIndex, 7)
    XCTAssertEqual(weather.hourly.count, 1)
  }
}