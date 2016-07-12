//
//  AddCityViewController.swift
//  MTTForecast
//
//  Created by Esteban Torres on 24/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// UI
import UIKit

//// WorldWeather
// DataControllers
import WorldWeatherAPI

protocol AddCityViewControllerDelegate: class {
  func addCityViewControllerCancel() -> Void
  func addCityViewControllerAddCity(forecast: CityForecastViewModel) -> Void
}

final class AddCityViewController: UIViewController {
  // MARK: - Properties
  weak var delegate: AddCityViewControllerDelegate? = nil
  
  // MARK: - UI Properties
  @IBOutlet weak var cityNameTextField: UITextField!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
  
  // MARK: - Regular life cycle
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.cityNameTextField.becomeFirstResponder()
  }
  
  // MARK: - Events
  
  @IBAction func cancelButtonTouched(sender: UIButton) {
    delegate?.addCityViewControllerCancel()
  }
  
  @IBAction func addButtonTouched(sender: UIButton) {
    self.cityNameTextField.resignFirstResponder()
    self.activityIndicatorView.startAnimating()
    if let cityName: String = self.cityNameTextField.text {
      let forecastVM = CityForecastViewModel(city: cityName, unit: .Metric)
      forecastVM.fiveDayForecast({ (success, error) in
        self.activityIndicatorView.stopAnimating()
        guard success == true && error == nil else {
          
          let alert = UIAlertController(title: "Oops! Something happened",
            message: "Unable to retrieve the forecast for «\(cityName)».\nPlease try again later.",
            preferredStyle: .Alert)
          alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { _ in
            alert.dismissViewControllerAnimated(true, completion: nil)
          }))
          self.presentViewController(alert, animated: true, completion: nil)
          
          return
        }
        
        self.delegate?.addCityViewControllerAddCity(forecastVM)
      })
    }
  }
}

// MARK: - UITextFieldDelegate

extension AddCityViewController: UITextFieldDelegate {
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    let currentText = (textField.text ?? "") as NSString
    let newText = currentText.stringByReplacingCharactersInRange(range, withString: string).stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    
    self.addButton.enabled = newText.characters.count > 0
    
    return true
  }
}