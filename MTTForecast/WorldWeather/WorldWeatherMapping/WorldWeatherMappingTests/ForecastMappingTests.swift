//
//  ForecastMappingTests.swift
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

class ForecastMappingTests: XCTestCase {
  private var json: [String: AnyObject] {
    get {
      /**
       `json` var had to be broken down into its components, otherwise the compiler would hang while
       trying to compile this test class.
       */
      let request = [
        "type": "City",
        "query": "London, United Kingdom"
      ]
      let currentCondition = [
        "observation_time": "02:51 AM",
        "temp_C": "13",
        "temp_F": "66",
        "weatherCode": "302",
        "weatherIconUrl": [
          "value": "http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0034_cloudy_with_heavy_rain_night.png"
        ],
        "weatherDesc": [
          "value": "Rain"
        ],
        "windspeedMiles": "4",
        "windspeedKmph": "7",
        "winddirDegree": "160",
        "winddir16Point": "SSE",
        "precipMM": "1.5",
        "humidity": "94",
        "visibility": "4",
        "pressure": "1017",
        "cloudcover": "0",
        "FeelsLikeC": "19",
        "FeelsLikeF": "66"
      ]
      let hourly = [
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
        "FeelsLikeF": "59"
      ]
      let json: [String: AnyObject] = [
        "request": [request],
        "current_condition": [ currentCondition ],
        "weather": [
          [
            "date": "2016-06-23",
            "maxtempC": "24",
            "maxtempF": "75",
            "mintempC": "14",
            "mintempF": "58",
            "uvIndex": "7",
            "hourly": [ hourly ]
          ]
        ]
      ]
      
      return json
    }
  }
  
  func testSuccessfulMapping() {
    let json = self.json
    let forecast = Forecast.from(json)
    XCTAssertNotNil(forecast)
    XCTAssertEqual(forecast?.currentCondition.detailsMetric.temperature, 13)
  }
}
