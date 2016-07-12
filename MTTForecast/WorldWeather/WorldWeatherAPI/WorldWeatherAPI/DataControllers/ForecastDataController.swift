//
//  ForecastDataController.swift
//  WorldWeatherAPI
//
//  Created by Esteban Torres on 23/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// Foundation
import Foundation

//// WorldWeatherCore
// Models
import WorldWeatherMapping
import WorldWeatherCore

/**
 *  @author Esteban Torres, 16-06-24
 *
 *  Container for all possible errors thrown by the `ForecastDataController`
 *
 *  @since 1.0.0
 */
public struct ForecastDataControllerError: ErrorType {
  /**
   The type of error thrown by `ForecastDataController`
   
   - author: Esteban Torres
   - date: 16-06-24
   
   - InvalidJSON:  Unable to extract a valid `Forecast` object from the provided `JSON`.
   - NetworkError: Unexpected network error.
   */
  public enum ForecastErrorType {
    case InvalidJSON
    case NetworkError
  }
  
  /**
   Error type
   
   - seealso: `ForecastErrorType`
   */
  public let errorType: ForecastErrorType
  
  /// Detailed description of the error.
  public let description: String?
  
  /// The internal/parent error.
  public let internalError: ErrorType?
}

/// `DataController` in charge of handling `Forecast` related methods.
public final class ForecastDataController {
  
  /**
   Retrieves the upcoming number of days of forecast defined by `followingDays` for the desired `city`.
   
   - author: Esteban Torres
   - date: 16-06-24
   
   - parameter city:       The name of the city which forecast will be retrieved.
   - parameter days:       The number of days to look further for the forecast of the provided `city`.
   - parameter offlineModeOn: Indicates if the request should be resolved against the live server or locally saved data set.
   - parameter completion: Handler that will be called upon completion. Will contain a `Forecast` object if the call was successful or an `ErrorType` otherwise.
   */
  public static func retrieveForecastForCity(city: String, forFollowingDays days: Int, offlineModeOn: Bool = false, completion: (forecast: Forecast?, error: ErrorType?) -> ()) -> Void {
    WorldWeatherAPIProvider.offlineModeOn = offlineModeOn
    WorldWeatherAPIManager.request(.ForecastForCity(city, upcomingDays: days)) { result in
      switch result {
      case .Success(let response):
        do {
          if let json = try NSJSONSerialization.JSONObjectWithData(response.data, options: .AllowFragments) as? [String: AnyObject],
            let data = json["data"] as? [String: AnyObject] {
            let forecast = Forecast.from(data)
            completion(forecast: forecast, error: nil)
          } else {
            completion(forecast: nil, error: ForecastDataControllerError(errorType: .InvalidJSON, description: "Unable to extract a valid Forecast object from the provided JSON.", internalError: nil))
          }
        } catch {
          completion(forecast: nil, error: ForecastDataControllerError(errorType: .InvalidJSON, description: "Unable to extract a valid Forecast object from the provided JSON.", internalError: error))
        }
        
      case .Failure(let error):
        completion(forecast: nil, error: ForecastDataControllerError(errorType: .NetworkError, description: nil, internalError: error))
      }
    }
  }
}