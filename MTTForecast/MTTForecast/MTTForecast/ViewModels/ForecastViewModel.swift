//
//  ForecastViewModel.swift
//  MTTForecast
//
//  Created by Esteban Torres on 25/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// Foundation
import Foundation

//// WorldWeather
// Models
import WorldWeatherCore

final class ForecastViewModel {
  // MARK: - Properties
  private var preLoadedData: Bool = false
  private var cityForecastViewModels: [CityForecastViewModel] = []
  private var cityNames: [String] {
    return self.cityForecastViewModels.map { $0.cityName }
  }
  
  var numberOfCities: Int {
    guard self.preLoadedData == true else { return 0 }
    
    return self.cityForecastViewModels.count
  }
  
  // MARK: - Regular life cycle
  init() {
    self.cityForecastViewModels = self.storedCities().map { CityForecastViewModel(city: $0, unit: .Metric) }
  }
  
  // MARK: - Public Methods
  
  func retrieveData(completion: (dataAvailable: Bool) -> ()) {
    guard self.cityForecastViewModels.count > 0 else {
      completion(dataAvailable: false)
      
      return
    }
    
    let group = dispatch_group_create()
    for cityVM in self.cityForecastViewModels {
      dispatch_group_enter(group)
      cityVM.fiveDayForecast({ (success, error) in
        dispatch_group_leave(group)
      })
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue()) {
      self.preLoadedData = true
      completion(dataAvailable: true)
    }
  }
  
  func cityForecastViewModelAtIndex(index: UInt) -> CityForecastViewModel {
    let intIndex = Int(index)
    assert(intIndex < self.cityForecastViewModels.count, "Index: \(index) cannot be greater than the cities array \(self.cityForecastViewModels.count)")
    
    return self.cityForecastViewModels[intIndex]
  }
  
  func addCityForecastViewModel(cityForecastViewModel: CityForecastViewModel) {
    synced(cityForecastViewModel) {
      self.cityForecastViewModels.append(cityForecastViewModel)
      self.saveCity()
    }
  }
  
  func removeCityForecastViewModelAtIndex(index: UInt) {
    let intIndex = Int(index)
    assert(intIndex < self.cityForecastViewModels.count, "Index: \(index) cannot be greater than the cities array \(self.cityForecastViewModels.count)")
    
    synced(cityForecastViewModels) {
      self.cityForecastViewModels.removeAtIndex(intIndex)
      self.saveCity()
    }
  }
}

// MARK: - Private Methods

private extension ForecastViewModel {
  func saveCity() {
    let filePath = self.pathForForecastsFile()
    if NSFileManager.defaultManager().fileExistsAtPath(filePath) {
      do {
        try NSFileManager.defaultManager().removeItemAtPath(filePath)
      } catch {
        print(error)
      }
    }
    
    NSKeyedArchiver.archiveRootObject(self.cityNames, toFile: filePath)
  }
  
  func synced(lock: AnyObject, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    
    defer {
      objc_sync_exit(lock)
    }
  }
  
  func pathForForecastsFile() -> String {
    if let docsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first,
      let docsURL = NSURL(string: docsDirectory) {
      let fileURL = docsURL.URLByAppendingPathComponent("forecasts")
      
      return fileURL.URLByAppendingPathExtension("data").absoluteString
    }
    
    fatalError("Unable to retrieve the application's documents path.")
  }
  
  func storedCities() -> [String] {
    let filePath = self.pathForForecastsFile()
    if let cities = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? [String]
      where NSFileManager.defaultManager().fileExistsAtPath(filePath) {
      return cities
    }
    
    return []
  }
}