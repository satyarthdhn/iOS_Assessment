//
//  UIKitReactiveController.swift
//  SwiftUIIntergrationProject
//
//  Created by Yuchen Nie on 4/5/24.
//

import UIKit

final class UIKitController: RootViewController<UIKitView> {
  
  private let viewModel: UIKitViewModelProtocol
  private var currentWeatherDataLoadStatus: DataLoadStatus = .loading
  private var weatherForecastDataLoadStatus: DataLoadStatus = .loading
  private let addresses: [String]
  private let dateFormatter: DateFormatter
  
  init(viewModel: UIKitViewModelProtocol,
       addresses: [String],
       dateFormatter: DateFormatter) {
    self.viewModel = viewModel
    self.addresses = addresses
    self.dateFormatter = dateFormatter
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
      currentWeatherDataLoadStatus = .loaded
      DispatchQueue.main.async {
        self.customView.updateCurrentWeather(currentWeather)
        self.customView.shouldShowUI(true)
        guard self.weatherForecastDataLoadStatus == .loaded else { return }
        self.customView.shouldShowLoading(false)
      }
    }
    
    viewModel.weatherForecastData.observe { [weak self] _ in
      guard let self else { return }
      weatherForecastDataLoadStatus = .loaded
      DispatchQueue.main.async {
        self.customView.tableView.reloadData()
        self.customView.shouldShowUI(true)
        guard self.currentWeatherDataLoadStatus == .loaded else { return }
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
  
  func getTableViewRowData(for indexPath: IndexPath) -> String {
    let weather = viewModel.weatherForecastData.value?.list[indexPath.row]
    let date = Date(timeIntervalSince1970: TimeInterval(weather?.dt ?? 0))
    let dateString = dateFormatter.string(from: date)
    let condition = weather?.weather.first?.description ?? ""
    let temperature = "temperature-value".localized(args: Int(weather?.temperatures.temp ?? 0.0))
                    
    return "\(dateString)\n\(condition)\n\(temperature)"
  }
  
}

// MARK: UICollectionViewDataSourceSetup

private typealias UICollectionViewDataSourceSetup = UIKitController
extension UICollectionViewDataSourceSetup: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return addresses.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.identifier,
                                                        for: indexPath) as? ButtonCollectionViewCell else { return ButtonCollectionViewCell() }
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
    currentWeatherDataLoadStatus = .loading
    weatherForecastDataLoadStatus = .loading
    viewModel.updateCurrentAddress(to: addresses[indexPath.row])
    customView.tableView.setContentOffset(.zero, animated: true)
  }
  
}

// MARK: UITableViewDatasourceSetup

private typealias UITableViewDatasourceSetup = UIKitController
extension UITableViewDatasourceSetup: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.weatherForecastData.value?.list.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier,
                                             for: indexPath)
    let weather = viewModel.weatherForecastData.value?.list[indexPath.row]
    let date = Date(timeIntervalSince1970: TimeInterval(weather?.dt ?? 0))
    let dateString = dateFormatter.string(from: date)
    let condition = weather?.weather.first?.description ?? ""
    let temperature = "temperature-value".localized(args: Int(weather?.temperatures.temp ?? 0.0))
                    
    cell.textLabel?.numberOfLines = 0
    cell.textLabel?.text = "\(dateString)\n\(condition)\n\(temperature)"
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

