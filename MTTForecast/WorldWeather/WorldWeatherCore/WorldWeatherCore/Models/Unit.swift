//
//  Units.swift
//  WorldWeatherCore
//
//  Created by Esteban Torres on 22/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// Foundation
import Foundation

/// Units of measurement for speeds, temperature and distance
public enum Unit: String {
  case Imperial = "imperial"
  case Metric = "metric"
  
  // MARK: Symbol/letter
  /// The temperature initial for the current unit.
  /// `C` for `.Metric` and `F` for `.Imperial`.
  public var temperatureLetter: String {
    get {
      switch self {
      case .Imperial:
        return "F"
      case .Metric:
        return "C"
      }
    }
  }
  
  /// The speed initial for the current unit.
  /// `Kmph` for `.Metric` and `M` for `.Imperial`.
  public var speedLetter: String {
    get {
      switch self {
      case .Imperial:
        return "M"
      case .Metric:
        return "Kmph"
      }
    }
  }
  
  // MARK: Names
  /// The temperature name for the current unit.
  /// `Celsius` for `.Metric` and `Fahrenheit` for `.Imperial`.
  public var temperatureUnit: String {
    get {
      switch self {
      case .Imperial:
        return "Fahrenheit"
      case .Metric:
        return "Celsius"
      }
    }
  }
  
  /// The speed name for the current unit.
  /// `Kmph` for `.Metric` and `Miles` for `.Imperial`.
  public var speedUnit: String {
    get {
      switch self {
      case .Imperial:
        return "Miles"
      case .Metric:
        return "Kmph"
      }
    }
  }
}