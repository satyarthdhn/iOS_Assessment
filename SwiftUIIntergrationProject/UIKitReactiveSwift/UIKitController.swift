//
//  UIKitReactiveController.swift
//  SwiftUIIntergrationProject
//
//  Created by Yuchen Nie on 4/5/24.
//

import UIKit

final class UIKitController: RootViewController<UIKitView> {
  
  private let viewModel: UIKitViewModelProtocol
  private var weatherForecastData: ForecastJSONData?
  private var isCurrentWeatherLoaded = false
  
  init(weatherForecastData: ForecastJSONData? = nil,
       viewModel: UIKitViewModelProtocol) {
    self.weatherForecastData = weatherForecastData
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    viewModel.viewDidLoad()
    customView.shouldShowUI(false)
    customView.shouldShowLoading(true)
  }
  
  func updateForecastData(_ forecastData: ForecastJSONData) {
    weatherForecastData = forecastData
    customView.tableView.reloadData()
  }
  
  override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
    customView.viewWillRotateToOrientation(toInterfaceOrientation)
  }
  
}

// MARK: SetupHelper

private typealias SetupHelper = UIKitController
private extension SetupHelper {
  
  func setup() {
    view.backgroundColor = .systemBackground
    setupCollectionView()
    setupTableView()
    bindViewModel()
  }
  
  func setupCollectionView() {
    customView.collectionView.delegate = self
    customView.collectionView.dataSource = self
    customView.collectionView.register(ButtonCollectionViewCell.self,
                                       forCellWithReuseIdentifier: ButtonCollectionViewCell.identifier)
  }
  
  func setupTableView() {
    customView.tableView.dataSource = self
    customView.tableView.delegate = self
    customView.tableView.register(UITableViewCell.self,
                                  forCellReuseIdentifier: UITableViewCell.identifier)
  }
  
  func bindViewModel() {
    viewModel.currentWeatherData.observe { [weak self] currentWeather in
      guard let currentWeather, let self else { return }
      isCurrentWeatherLoaded = true
      DispatchQueue.main.async {
        self.customView.updateCurrentWeather(currentWeather)
        self.customView.shouldShowUI(true)
        guard self.weatherForecastData != nil else { return }
        self.customView.shouldShowLoading(false)
      }
    }
    
    viewModel.weatherForecastData.observe { [weak self] forecast in
      guard let forecast, let self else { return }
      DispatchQueue.main.async {
        self.updateForecastData(forecast)
        self.customView.shouldShowUI(true)
        guard self.isCurrentWeatherLoaded else { return }
        self.customView.shouldShowLoading(false)
      }
    }
    
    viewModel.error.observe { [weak self] errorString in
      guard errorString.count > 0 else { return }
      DispatchQueue.main.async {
        self?.customView.shouldShowLoading(false)
        self?.showAlert(title: "error".localized, msg: errorString)
      }
    }
  }
  
}

// MARK: UICollectionViewDataSourceSetup

private typealias UICollectionViewDataSourceSetup = UIKitController
extension UICollectionViewDataSourceSetup: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Addresses.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.identifier,
                                                  for: indexPath) as! ButtonCollectionViewCell
    cell.setTitle("address-numbered".localized(args: indexPath.item + 1))
    return cell
  }
  
}

// MARK: UICollectionViewDelegateFlowLayoutSetup

private typealias UICollectionViewDelegateFlowLayoutSetup = UIKitController
extension UICollectionViewDelegateFlowLayoutSetup: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: Constant.collectionViewItemWidth, 
                  height: Constant.collectionViewItemHeight)
  }
  
}

// MARK: UICollectionViewDelegateSetup

private typealias UICollectionViewDelegateSetup = UIKitController
extension UICollectionViewDelegateSetup: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    customView.shouldShowUI(false)
    customView.shouldShowLoading(true)
    viewModel.updateCurrentAddress(to: Addresses[indexPath.row])
  }
  
}

// MARK: UITableViewDatasourceSetup

private typealias UITableViewDatasourceSetup = UIKitController
extension UITableViewDatasourceSetup: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return weatherForecastData?.list.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier,
                                             for: indexPath)
    let weather = weatherForecastData?.list[indexPath.row]
    let date = Date(timeIntervalSince1970: TimeInterval(weather?.dt ?? 0))
    let condition = weather?.weather.first?.description ?? ""
    let temperature = "temperature-value".localized(args: weather?.temperatures.temp ?? 0.0)
                    
    cell.textLabel?.numberOfLines = 0
    cell.textLabel?.text = "\(date)\n\(condition)\n\(temperature)"
    return cell
  }
  
}

// MARK: UITableViewDelegateSetup

private typealias UITableViewDelegateSetup = UIKitController
extension UITableViewDelegateSetup: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return Constant.tableViewRowHeight
  }
  
}

// MARK: Constants

private typealias Constant = ButtonCollectionViewCell
private extension Constant {

  static let tableViewRowHeight: CGFloat = 60
  static let collectionViewItemHeight: CGFloat = 60
  static let collectionViewItemWidth: CGFloat = 140
  
}

