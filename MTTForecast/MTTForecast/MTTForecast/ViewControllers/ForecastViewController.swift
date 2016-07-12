//
//  ForecastViewController.swift
//  MTTForecast
//
//  Created by Esteban Torres on 24/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

//// Native Frameworks
// UI
import UIKit

final class ForecastViewController: UIViewController {
  // MARK: - Properties
  private let forecastViewModel = ForecastViewModel()
  
  // MARK: - UI Properties
  @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!
  
  // MARK: - Regular life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configure()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    forecastViewModel.retrieveData { [unowned self] (dataAvailable) in
      self.activityIndicatorView.stopAnimating()
      if dataAvailable == false {
        self.showCityVC()
      } else {
        self.pageControl.numberOfPages = self.forecastViewModel.numberOfCities
        self.collectionView.reloadData()
      }
    }
  }
}

// MARK: - AddCityViewControllerDelegate

extension ForecastViewController: AddCityViewControllerDelegate {
  func addCityViewControllerCancel() {
    self.dismissViewControllerAnimated(true, completion: { _ in
      if self.forecastViewModel.numberOfCities <= 0 {
        self.showCityVC()
      }
    })
  }
  
  func addCityViewControllerAddCity(forecast: CityForecastViewModel) {
    forecastViewModel.addCityForecastViewModel(forecast)
    self.pageControl.numberOfPages = self.forecastViewModel.numberOfCities
    self.dismissViewControllerAnimated(true, completion: { _ in
      self.collectionView.performBatchUpdates({
        let indexPath = NSIndexPath(forItem: self.forecastViewModel.numberOfCities - 1, inSection: 0)
        self.collectionView.insertItemsAtIndexPaths([indexPath])
        }, completion: nil)
    })
  }
}

// MARK: - Private Methods

private extension ForecastViewController {
  func configure() {
    // Colors
    self.view.backgroundColor           = .lightGrayColor()
    self.collectionView.backgroundColor = .whiteColor()
    
    // NavBar
    self.title = "Forecast"
    
    let addCityButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(showCityVC))
    self.navigationItem.rightBarButtonItem = addCityButton
    
    let removeCityButton = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: #selector(removeCity))
    removeCityButton.tintColor = .redColor()
    self.navigationItem.leftBarButtonItem = removeCityButton
  }
  
  @objc func removeCity() {
    // Let's disable user interactions while we delete the city
    self.collectionView.userInteractionEnabled      = false
    self.navigationItem.leftBarButtonItem?.enabled  = false
    self.navigationItem.rightBarButtonItem?.enabled = false
    
    let index = UInt(self.pageControl.currentPage)
    self.forecastViewModel.removeCityForecastViewModelAtIndex(index)
    self.collectionView.performBatchUpdates({
      let indexPath = NSIndexPath(forItem: Int(index), inSection: 0)
      self.collectionView.deleteItemsAtIndexPaths([indexPath])
      }, completion: { _ in
        self.pageControl.numberOfPages = self.forecastViewModel.numberOfCities
    })
    
    // Be sure to ALWAYS enable interactions after the processing is done
    defer {
      self.collectionView.userInteractionEnabled      = true
      self.navigationItem.leftBarButtonItem?.enabled  = true
      self.navigationItem.rightBarButtonItem?.enabled = true
    }
  }
  
  @objc func showCityVC() {
    let addCityVC = StoryboardScene.Main.instantiateAddCityViewController()
    addCityVC.delegate = self
    
    self.presentViewController(addCityVC, animated: true, completion: nil)
  }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension ForecastViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func scrollViewDidScroll(scrollView: UIScrollView) {
    let page: Int = Int(scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds))
    self.pageControl.currentPage = page
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CityForecastCollectionViewCell.Identifier, forIndexPath: indexPath) as? CityForecastCollectionViewCell else {
      fatalError("Unable to dequeue the correct cell.")
    }
    
    let cityForecastVM = self.forecastViewModel.cityForecastViewModelAtIndex(UInt(indexPath.item))
    cell.configureWithCityForecast(cityForecastVM)
    
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.forecastViewModel.numberOfCities
  }
}

// MARK: -

extension ForecastViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSizeZero
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    return CGSizeZero
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let size = collectionView.bounds.size
    return CGSizeMake(size.width, size.height * 0.88)
  }
}