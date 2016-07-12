//
//  WeatherConditionMappingTests.swift
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

class WeatherConditionMappingTests: XCTestCase {
  private var json: [String: AnyObject] {
    get {
      let json = [
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
    let json = self.json
    let conditionOptional = WeatherCondition.from(json)
    XCTAssertNotNil(conditionOptional)
    guard let condition = conditionOptional else {
      XCTFail()
      
      return 
    }
    
    XCTAssertEqual(condition.time, 0)
    XCTAssertEqual(condition.detailsMetric.temperature, 19)
    XCTAssertEqual(condition.detailsImperial.temperature, 67)
    XCTAssertEqual(condition.detailsImperial.windspeed, 7)
    XCTAssertEqual(condition.detailsMetric.windspeed, 12)
    XCTAssertEqual(condition.windDirectionDegree, 66)
    XCTAssertEqual(condition.windDirection16Point, "ENE")
    XCTAssertEqual(condition.weatherCode, 143)
    XCTAssertNotNil(condition.weatherIconUrl)
    XCTAssertEqual(condition.weatherIconUrl?.absoluteString, "http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0006_mist.png")
    XCTAssertEqual(condition.weatherDesc, "Mist")
    XCTAssertEqual(condition.precipationMM, 0.1)
    XCTAssertEqual(condition.humidity, 96)
    XCTAssertEqual(condition.visibility, 2)
    XCTAssertEqual(condition.pressure, 1016)
    XCTAssertEqual(condition.cloudcover, 64)
    XCTAssertEqual(condition.detailsMetric.heatIndex, 15)
    XCTAssertEqual(condition.detailsImperial.heatIndex, 59)
    XCTAssertEqual(condition.detailsMetric.dewPoint, 15)
    XCTAssertEqual(condition.detailsImperial.dewPoint, 58)
    XCTAssertEqual(condition.detailsMetric.windChill, 15)
    XCTAssertEqual(condition.detailsImperial.windChill, 59)
    XCTAssertEqual(condition.detailsImperial.windGust, 6)
    XCTAssertEqual(condition.detailsMetric.windGust, 9)
    XCTAssertEqual(condition.detailsMetric.feelsLike, 15)
    XCTAssertEqual(condition.detailsImperial.feelsLike, 59)
    XCTAssertEqual(condition.chanceOfRain, 35)
    XCTAssertEqual(condition.chanceOfRemdry, 0)
    XCTAssertEqual(condition.chanceOfWindy, 0)
    XCTAssertEqual(condition.chanceOfOvercast, 0)
    XCTAssertEqual(condition.chanceOfSunshine, 37)
    XCTAssertEqual(condition.chanceOfFrost, 0)
    XCTAssertEqual(condition.chanceOfHighTemp, 0)
    XCTAssertEqual(condition.chanceOfFog, 0)
    XCTAssertEqual(condition.chanceOfSnow, 0)
    XCTAssertEqual(condition.chanceOfThunder, 96)
  }
  
  func testUnsuccessfulMapping() {
    let json: [String: AnyObject] = [:]
    
    let condition = WeatherCondition.from(json)
    XCTAssertNil(condition)
  }
  
  func testDefaultEmptyValues() {
    var mJSON = json
    mJSON.removeValueForKey("weatherDesc")
    mJSON.removeValueForKey("weatherIconUrl")
    
    let condition = WeatherCondition.from(mJSON)
    XCTAssertNotNil(condition)
    XCTAssertEqual("N/A", condition?.weatherDesc)
    XCTAssertNil(condition?.weatherIconUrl)
  }
}
