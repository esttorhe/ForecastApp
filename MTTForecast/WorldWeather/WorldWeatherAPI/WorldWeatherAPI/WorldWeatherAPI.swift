//
//  WorldWeatherAPI.swift
//  WorldWeatherAPI
//
//  Created by Esteban Torres on 22/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// Foundation
import Foundation

//// Pods
// Network
import Moya

// Security
import Keys

enum WorldWeatherAPI {
  case ForecastForCity(String, upcomingDays: Int)
}

extension WorldWeatherAPI: TargetType {
  var baseURL: NSURL {
    guard let url = NSURL(string: "http://api.worldweatheronline.com/premium/v1/")  else {
      fatalError("Unable to create a valid URL object for the WorldWeatherOnline API")
    }
    
    return url
  }
  
  var path: String {
    switch self {
    case .ForecastForCity: return "weather.ashx"
    }
  }
  
  var method: Moya.Method {
    return .GET
  }
  
  var parameters: [String: AnyObject]? {
    let keys = WorldweatherapiKeys()
    var parameters: [String: AnyObject] = [
      "key": keys.aPIKey(),
      "format": "json"
    ]
    
    switch self {
    case .ForecastForCity(let city, let upcomingDays):
      parameters["q"] = city.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
      parameters["num_of_days"] = upcomingDays
    }
    
    return parameters
  }
  
  var sampleData: NSData {
    switch self {
    case .ForecastForCity(let city, let days):
      if let bundle = NSBundle(identifier: "es.estebantorr.WorldWeatherAPITests") ?? NSBundle(identifier: "es.estebantorr.MTTForecastTests"),
        let path = bundle.pathForResource("Forecast-\(city)-\(days)", ofType: "json"),
        let data = NSData(contentsOfFile: path) {
          return data
      }
    }
    
    return NSData()
  }
}

// MARK: - Provider setup

private func JSONResponseDataFormatter(data: NSData) -> NSData {
  do {
    let dataAsJSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
    let prettyData =  try NSJSONSerialization.dataWithJSONObject(dataAsJSON, options: .PrettyPrinted)
    return prettyData
  } catch {
    return data //fallback to original data if it cant be serialized
  }
}

final class WorldWeatherAPIProvider: MoyaProvider<WorldWeatherAPI> {
  static var offlineModeOn: Bool = false
  
  override init(endpointClosure: EndpointClosure = MoyaProvider.DefaultEndpointMapping,
              requestClosure: RequestClosure = MoyaProvider.DefaultRequestMapping,
              stubClosure: StubClosure = MoyaProvider.NeverStub,
              manager: Manager = MoyaProvider<WorldWeatherAPI>.DefaultAlamofireManager(),
              plugins: [PluginType] = []) {
    super.init(stubClosure: { _ -> Moya.StubBehavior in
      return WorldWeatherAPIProvider.offlineModeOn ? .Immediate : .Never
    })
  }
}

let WorldWeatherAPIManager = WorldWeatherAPIProvider(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])