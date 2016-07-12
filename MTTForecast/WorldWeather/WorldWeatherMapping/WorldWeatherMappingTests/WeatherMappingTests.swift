//
//  WeatherMappingTests.swift
//  WorldWeatherMapping
//
//  Created by Esteban Torres on 23/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// Tests
import XCTest

//// WorldWetherMapping
// Models
import WorldWeatherCore

// Mappings
@testable import WorldWeatherMapping

//// Pods
// JSON Parsing
import Mapper

class WeatherMappingTests: XCTestCase {
  private var json: [AnyObject] {
    get {
      let json = [
        [
          "date": "2016-06-23",
          "astronomy": [
            "sunrise": "04:43 AM",
            "sunset": "09:22 PM",
            "moonrise": "11:09 PM",
            "moonset": "07:59 AM"
          ],
          "maxtempC": "24",
          "maxtempF": "75",
          "mintempC": "14",
          "mintempF": "58",
          "uvIndex": "7",
          "hourly": [
            [
              "time": "0",
              "tempC": "19",
              "tempF": "67",
              "windspeedMiles": "7",
              "windspeedKmph": "12",
              "winddirDegree": "66",
              "winddir16Point": "ENE",
              "weatherCode": "143",
              "weatherIconUrl": [
                "value": "http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0006_mist.png"
              ],
              "weatherDesc": [
                "value": "Mist"
              ],
              "precipMM": "0.1",
              "humidity": "96",
              "visibility": "2",
              "pressure": "1016",
              "cloudcover": "64",
              "HeatIndexC": "15",
              "HeatIndexF": "59",
              "DewPointC": "15",
              "DewPointF": "58",
              "WindChillC": "15",
              "WindChillF": "59",
              "WindGustMiles": "6",
              "WindGustKmph": "9",
              "FeelsLikeC": "15",
              "FeelsLikeF": "59",
              "chanceofrain": "35",
              "chanceofremdry": "0",
              "chanceofwindy": "0",
              "chanceofovercast": "0",
              "chanceofsunshine": "37",
              "chanceoffrost": "0",
              "chanceofhightemp": "0",
              "chanceoffog": "0",
              "chanceofsnow": "0",
              "chanceofthunder": "96"
            ]
          ]
        ]
      ]
      
      return json
    }
  }
  
  func testSuccessfulMapping() {
    let json = self.json
    let weather = Weather.from(json)
    XCTAssertNotNil(weather)
    XCTAssertEqual(1, weather?.count)
    let first = weather?.first
    XCTAssertNotNil(first)
    XCTAssertEqual(first?.hourly.count, 1)
  }
}