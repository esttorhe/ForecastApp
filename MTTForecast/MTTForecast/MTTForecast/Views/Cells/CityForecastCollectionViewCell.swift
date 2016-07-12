//
//  CityForecastCollectionViewCell.swift
//  MTTForecast
//
//  Created by Esteban Torres on 26/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// UI
import UIKit

//// Pods
// UI
import SDWebImage

final class CityForecastCollectionViewCell: UICollectionViewCell {
  // MARK: - Constants
  static let Identifier: String = "CityForecastCollectionViewCellIdentifier"
  
  // MARK: - UI Properties
  @IBOutlet weak var cityNameLabel: UILabel!
  @IBOutlet weak var weatherIconImageView: UIImageView!
  @IBOutlet weak var currentTemperatureLabel: UILabel!
  @IBOutlet weak var dayForecastContainerView: UIStackView!
  
  // MARK: - Properties
  private weak var cityForecastViewModel: CityForecastViewModel?
  
  // MARK: - Regular life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    self.weatherIconImageView.layer.masksToBounds = true
    
    for _ in 0..<5 {
      let view = UINib(nibName: "DayForecastView", bundle: nil).instantiateWithOwner(nil, options: nil).last! as! DayForecastView
      view.layer.borderColor = UIColor.blackColor().CGColor
      view.layer.borderWidth = 2.0
      dayForecastContainerView.addArrangedSubview(view)
    }
  }
  
  // MARK: - Public Methods
  func configureWithCityForecast(cityForecast: CityForecastViewModel) {
    self.layoutIfNeeded()
    self.weatherIconImageView.layoutIfNeeded()
    self.weatherIconImageView.layer.cornerRadius  = CGRectGetWidth(self.weatherIconImageView.bounds) / 2.0
    
    self.cityForecastViewModel = cityForecast
    self.cityNameLabel.text = cityForecast.cityName
    self.currentTemperatureLabel.text = "Current Temp: \(cityForecast.currentTemperature) | Feels like: \(cityForecast.currentTemperatureFeelsLike)"
    if let currentWeatherIconURL = cityForecast.currentWeatherIconURL {
      self.weatherIconImageView.sd_setImageWithURL(currentWeatherIconURL)
    }
    
    // Zip the array of views with the array of daily forecast
    for pair in zip(self.dayForecastContainerView.arrangedSubviews, cityForecast.dailyForecasts) {
      let view = pair.0 as! DayForecastView
      view.configure(withDailyForecastViewModel: pair.1)
    }
  }
}