//
//  DayForecastView.swift
//  MTTForecast
//
//  Created by Esteban Torres on 27/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// UI
import UIKit

final class DayForecastView: UIView {
  // MARK: - UI Properties
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var minTemperatureLabel: UILabel!
  @IBOutlet weak var maxTemperatureLabel: UILabel!
  
  // MARK: - Public Methods
  func configure(withDailyForecastViewModel dailyForecastVC: DailyForecastViewModel) {
    self.dateLabel.text = dailyForecastVC.date
    self.minTemperatureLabel.text = "Min Temp\n\(dailyForecastVC.minTemperature)"
    self.maxTemperatureLabel.text = "Max Temp\n\(dailyForecastVC.maxTemperature)"
  }
}