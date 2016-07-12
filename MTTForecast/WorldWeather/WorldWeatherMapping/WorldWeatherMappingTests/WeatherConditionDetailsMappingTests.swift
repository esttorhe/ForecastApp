//
//  WeatherConditionDetailsMappingTests.swift
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

class WeatherConditionDetailsMappingTests: XCTestCase {
  private var json: [String: AnyObject] {
    get {
      let json: [String: AnyObject] = [
        "time": "0",
        "tempC": "19",
        "tempF": "67",
        "windspeedMiles": "7",
        "windspeedKmph": "12",
        "winddirDegree": "66",
        "winddir16Point": "ENE",
        "weatherCode": "143",
        "weatherIconUrl": [
          ["value": "http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0006_mist.png"]
        ],
        "weatherDesc": [
          ["value": "Mist"]
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
      
      return json
    }
  }
  
  func testSuccessfullMapping() {
    let conditionDetails = WeatherConditionDetails.from(json, withUnit: .Imperial)
    XCTAssertNotNil(conditionDetails)
    XCTAssertEqual(Unit.Imperial, conditionDetails?.unit)
  }
  
  func testUnsuccessfulMapping() {
    let json: [String: AnyObject] = [:]
    
    let conditionDetails = WeatherConditionDetails.from(json, withUnit: .Imperial)
    XCTAssertNil(conditionDetails)
  }
  
  func testSuccessfulImperialModel() {
    let conditionDetails = WeatherConditionDetails.from(json, withUnit: .Imperial)
    XCTAssertEqual(conditionDetails?.windChill, 59)
    XCTAssertEqual(conditionDetails?.temperature, 67)
    XCTAssertEqual(conditionDetails?.windspeed, 7)
    XCTAssertEqual(conditionDetails?.heatIndex, 59)
    XCTAssertEqual(conditionDetails?.dewPoint, 58)
    XCTAssertEqual(conditionDetails?.windGust, 6)
    XCTAssertEqual(conditionDetails?.feelsLike, 59)
  }
  
  func testSuccessfulMetricModel() {
    let conditionDetails = WeatherConditionDetails.from(json, withUnit: .Metric)
    XCTAssertEqual(conditionDetails?.windChill, 15)
    XCTAssertEqual(conditionDetails?.temperature, 19)
    XCTAssertEqual(conditionDetails?.windspeed, 12)
    XCTAssertEqual(conditionDetails?.heatIndex, 15)
    XCTAssertEqual(conditionDetails?.dewPoint, 15)
    XCTAssertEqual(conditionDetails?.windGust, 9)
    XCTAssertEqual(conditionDetails?.feelsLike, 15)
  }
  
  func testMappableInitShouldFail() {
    XCTAssertThrowsError(try WeatherConditionDetails(map: Mapper(JSON: json)))
  }
}
