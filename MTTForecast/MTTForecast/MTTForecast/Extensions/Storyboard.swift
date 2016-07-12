// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation
import UIKit

protocol StoryboardSceneType {
  static var storyboardName: String { get }
}

extension StoryboardSceneType {
  static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: self.storyboardName, bundle: nil)
  }

  static func initialViewController() -> UIViewController {
    guard let vc = storyboard().instantiateInitialViewController() else {
      fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
    }
    return vc
  }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
  func viewController() -> UIViewController {
    return Self.storyboard().instantiateViewControllerWithIdentifier(self.rawValue)
  }
  static func viewController(identifier: Self) -> UIViewController {
    return identifier.viewController()
  }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
  func performSegue<S: StoryboardSegueType where S.RawValue == String>(segue: S, sender: AnyObject? = nil) {
    performSegueWithIdentifier(segue.rawValue, sender: sender)
  }
}

struct StoryboardScene {
  enum LaunchScreen: StoryboardSceneType {
    static let storyboardName = "LaunchScreen"
  }
  enum Main: String, StoryboardSceneType {
    static let storyboardName = "Main"

    case AddCityViewControllerScene = "AddCityViewController"
    static func instantiateAddCityViewController() -> AddCityViewController {
      guard let vc = StoryboardScene.Main.AddCityViewControllerScene.viewController() as? AddCityViewController
      else {
        fatalError("ViewController 'AddCityViewController' is not of the expected class AddCityViewController.")
      }
      return vc
    }

    case ForecastViewControllerIDScene = "ForecastViewControllerID"
    static func instantiateForecastViewControllerID() -> ForecastViewController {
      guard let vc = StoryboardScene.Main.ForecastViewControllerIDScene.viewController() as? ForecastViewController
      else {
        fatalError("ViewController 'ForecastViewControllerID' is not of the expected class ForecastViewController.")
      }
      return vc
    }
  }
}

struct StoryboardSegue {
}
