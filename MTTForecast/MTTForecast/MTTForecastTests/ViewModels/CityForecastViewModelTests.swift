//
//  CityForecastViewModelTests.swift
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

class CityForecastViewModelTests: XCTestCase {
  func testMetricInitialization() {
    let expectation = expectationWithDescription("Retrieving forecast for 5 days for London [Metric]")
    let cityForecastViewModel = CityForecastViewModel(city: "London", unit: .Metric, offlineModeOn: true)
    XCTAssertNotNil(cityForecastViewModel)
    cityForecastViewModel.fiveDayForecast { (success, error) in
      XCTAssertTrue(success)
      XCTAssertNil(error)
      XCTAssertEqual(cityForecastViewModel.cityName, "London")
      XCTAssertEqual(cityForecastViewModel.currentWeatherDescription, "Partly Cloudy ")
      XCTAssertEqual(cityForecastViewModel.currentTemperature, "22.0 C")
      XCTAssertEqual(cityForecastViewModel.currentTemperatureFeelsLike, "24.0 C")
      XCTAssertEqual(cityForecastViewModel.numberOfDailyForecasts, 5)
      let fistDay = cityForecastViewModel.dailyForecastViewModelAtIndex(0)
      XCTAssertNotNil(fistDay)
      XCTAssertEqual(fistDay.date, "6/24/16")
      XCTAssertEqual(fistDay.maxTemperature, "22.0 C")
      XCTAssertEqual(fistDay.minTemperature, "14.0 C")
      
      let lastDay = cityForecastViewModel.dailyForecastViewModelAtIndex(4)
      XCTAssertNotNil(lastDay)
      XCTAssertEqual(lastDay.date, "6/28/16")
      XCTAssertEqual(lastDay.maxTemperature, "21.0 C")
      XCTAssertEqual(lastDay.minTemperature, "10.0 C")
      
      expectation.fulfill()
    }
    
    waitForExpectationsWithTimeout(5.0) { error in
      XCTAssertNil(error)
    }
  }
  
  func testImperialInitialization() {
    let expectation = expectationWithDescription("Retrieving forecast for 5 days for London [Imperial]")
    let cityForecastViewModel = CityForecastViewModel(city: "London", unit: .Imperial, offlineModeOn: true)
    XCTAssertNotNil(cityForecastViewModel)
    cityForecastViewModel.fiveDayForecast { (success, error) in
      XCTAssertTrue(success)
      XCTAssertNil(error)
      XCTAssertEqual(cityForecastViewModel.cityName, "London")
      XCTAssertEqual(cityForecastViewModel.currentWeatherDescription, "Partly Cloudy ")
      XCTAssertEqual(cityForecastViewModel.currentTemperature, "72.0 F")
      XCTAssertEqual(cityForecastViewModel.currentTemperatureFeelsLike, "76.0 F")
      XCTAssertEqual(cityForecastViewModel.numberOfDailyForecasts, 5)
      let fistDay = cityForecastViewModel.dailyForecastViewModelAtIndex(0)
      XCTAssertNotNil(fistDay)
      XCTAssertEqual(fistDay.date, "6/24/16")
      XCTAssertEqual(fistDay.maxTemperature, "72.0 F")
      XCTAssertEqual(fistDay.minTemperature, "56.0 F")
      
      let lastDay = cityForecastViewModel.dailyForecastViewModelAtIndex(4)
      XCTAssertNotNil(lastDay)
      XCTAssertEqual(lastDay.date, "6/28/16")
      XCTAssertEqual(lastDay.maxTemperature, "69.0 F")
      XCTAssertEqual(lastDay.minTemperature, "50.0 F")
      
      expectation.fulfill()
    }
    
    waitForExpectationsWithTimeout(5.0) { error in
      XCTAssertNil(error)
    }
  }
}
