//
//  DailyForecastViewModelTests.swift
//  MTTForecast
//
//  Created by Esteban Torres on 25/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// Test
import XCTest

//// WorldWeather
// Models
import WorldWeatherCore

// ViewModels
@testable import MTTForecast

class DailyForecastViewModelTests: XCTestCase {
  private lazy var dateFormatter: NSDateFormatter = {
    let dfKey = "dailyForecastDateFormatter"
    let dateFormatter: NSDateFormatter
    if let df = NSThread.mainThread().threadDictionary[dfKey] as? NSDateFormatter {
      dateFormatter = df
    } else {
      dateFormatter = NSDateFormatter()
      dateFormatter.dateStyle = .ShortStyle
      NSThread.mainThread().threadDictionary[dfKey] = dateFormatter
    }
    
    return dateFormatter
  }()
  
  var weather: Weather?
  var date: NSDate = NSDate()
  
  override func setUp() {
    super.setUp()
    self.date = NSDate()
    
    let weather = Weather(date: date,
                          maxTemperatureCelsius: 24,
                          maxTemperatureFahrenheit: 75,
                          minTemperatureCelsius: 14,
                          minTemperatureFahrenheit: 58,
                          uvIndex: 7,
                          hourly: [])
    self.weather = weather
  }
  
  override func tearDown() {
    self.weather = nil
    super.tearDown()
  }
  
  func testMetricFormatting() {
    let dailyForecast = DailyForecastViewModel(weather: weather!, unit: .Metric)
    XCTAssertNotNil(dailyForecast)
    XCTAssertEqual("24.0 C", dailyForecast.maxTemperature)
    XCTAssertEqual("14.0 C", dailyForecast.minTemperature)
    XCTAssertEqual(dateFormatter.stringFromDate(date), dailyForecast.date)
  }
  
  func testImperialFormatting() {
    let dailyForecast = DailyForecastViewModel(weather: weather!, unit: .Imperial)
    XCTAssertNotNil(dailyForecast)
    XCTAssertEqual("75.0 F", dailyForecast.maxTemperature)
    XCTAssertEqual("58.0 F", dailyForecast.minTemperature)
    XCTAssertEqual(dateFormatter.stringFromDate(date), dailyForecast.date)
  }
}
