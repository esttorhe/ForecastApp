//
//  CustomConvertibleTests.swift
//  WorldWeatherMapping
//
//  Created by Esteban Torres on 23/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// Tests
import XCTest

// Mappings
@testable import WorldWeatherMapping

class CustomConvertibleTests: XCTestCase {
  func testExtractFloat() {
    let float: Float = try! extractFloat("7.8")
    XCTAssertEqualWithAccuracy(float, 7.8, accuracy: 0.1)
  }
  
  func testExtractFloatFailure() {
    XCTAssertThrowsError(try extractFloat("FAIL"))
  }
  
  func testExtractInt() {
    let int: Int = try! extractInt("7")
    XCTAssertEqual(int, 7)
  }
  
  func testExtractIntFailure() {
    XCTAssertThrowsError(try extractInt("7.8"))
  }
  
  func testextractTime() {
    let time: NSDate = try! extractTime("02:51 AM")
    let components = NSDateComponents()
    
    components.day = 1
    components.month = 1
    components.year = 2000
    components.hour = 2
    components.minute = 51
    components.calendar = NSCalendar.currentCalendar()
    
    XCTAssertEqual(time, components.date!)
  }
  
  func testExtractTimeFailure() {
    XCTAssertThrowsError(try extractTime("FAIL"))
  }
  
  func testextractDate() {
    let time: NSDate = try! extractDate("2016-06-23")
    let components = NSDateComponents()
    
    components.day = 23
    components.month = 6
    components.year = 2016
    components.hour = 0
    components.minute = 00
    components.calendar = NSCalendar.currentCalendar()
    
    XCTAssertEqual(time, components.date!)
  }
  
  func testExtractDateFailure() {
    XCTAssertThrowsError(try extractTime("FAIL"))
  }
}
