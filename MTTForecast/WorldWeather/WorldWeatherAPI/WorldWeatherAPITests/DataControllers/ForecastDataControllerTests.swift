//
//  ForecastDataControllerTests.swift
//  WorldWeatherAPI
//
//  Created by Esteban Torres on 23/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// Test
import XCTest

//// WorldWeather
// Models
import WorldWeatherCore

// DataControllers
@testable import WorldWeatherAPI

class ForecastDataControllerTests: XCTestCase {
  func testSuccessfulForecastRetrieval() {
    let expectation = expectationWithDescription("Get London forecast for the upcoming 5 days")
    ForecastDataController.retrieveForecastForCity("London", forFollowingDays: 5, offlineModeOn: true) { forecast, error in
      XCTAssertNotNil(forecast)
      XCTAssertNil(error)
      XCTAssertEqual(5, forecast?.weather.count)
      XCTAssertNotNil(forecast?.currentCondition.weatherIconUrl)
      
      expectation.fulfill()
    }
    
    waitForExpectationsWithTimeout(5.0) { error in
      XCTAssertNil(error)
    }
  }
  
  func testInvalidForecastRetrieval() {
    let expectation = expectationWithDescription("Get INVALID forecast for the upcoming 5 days")
    ForecastDataController.retrieveForecastForCity("INVALID", forFollowingDays: 5, offlineModeOn: true) { forecast, error in
      XCTAssertNil(forecast)
      XCTAssertNotNil(error)
      
      guard let invalidError = error as? ForecastDataControllerError else {
        XCTFail("DataController failed with an unexpected error. Should have been \(ForecastDataControllerError.self)")
        
        return
      }
      
      XCTAssertEqual(invalidError.errorType, ForecastDataControllerError.ForecastErrorType.InvalidJSON)
      expectation.fulfill()
    }
    
    waitForExpectationsWithTimeout(5.0) { error in
      XCTAssertNil(error)
    }
  }
}
