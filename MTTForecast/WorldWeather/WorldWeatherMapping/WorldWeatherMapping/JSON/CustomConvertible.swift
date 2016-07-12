//
//  CustomConvertible.swift
//  WorldWeatherMapping
//
//  Created by Esteban Torres on 23/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// Foundation
import Foundation

//// Pods
// JSON Parsing
import Mapper

internal func extractFloat(object: AnyObject?) throws -> Float {
  guard let stringObject = object as? String,
    let number = Float(stringObject) else {
      throw MapperError.ConvertibleError(value: object, type: String.self)
  }
  
  return number
}

internal func extractInt(object: AnyObject?) throws -> Int {
  guard let stringObject = object as? String,
    let number = Int(stringObject) else {
      throw MapperError.ConvertibleError(value: object, type: String.self)
  }
  
  return number
}

internal func extractTime(object: AnyObject?) throws -> NSDate {
  let dateFormatter: NSDateFormatter
  if let df = NSThread.mainThread().threadDictionary.objectForKey("timeFormatter") as? NSDateFormatter {
    dateFormatter = df
  } else {
    dateFormatter = NSDateFormatter()
    dateFormatter.timeStyle = .ShortStyle
    NSThread.mainThread().threadDictionary.setValue(dateFormatter, forKey: "timeFormatter")
  }
  
  guard let stringObject = object as? String,
    let date = dateFormatter.dateFromString(stringObject) else {
      throw MapperError.ConvertibleError(value: object, type: String.self)
  }
  
  return date
}

internal func extractDate(object: AnyObject?) throws -> NSDate {
  let dateFormatter: NSDateFormatter
  if let df = NSThread.mainThread().threadDictionary.objectForKey("dateFormatter") as? NSDateFormatter {
    dateFormatter = df
  } else {
    dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "y-MM-dd"
    NSThread.mainThread().threadDictionary.setValue(dateFormatter, forKey: "dateFormatter")
  }
  
  guard let stringObject = object as? String,
    let date = dateFormatter.dateFromString(stringObject) else {
      throw MapperError.ConvertibleError(value: object, type: String.self)
  }
  
  return date
}