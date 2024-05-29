//
//  UIKitView.swift
//  SwiftUIIntergrationProject
//
//  Created by Satyarth Kumar Prasad on 28/05/24.
//

import UIKit

final class UIKitView: UIView {
  
  private let locationLabel: UILabel = {
    let locationLabel = UILabel()
    locationLabel.font = UIFont.systemMedium
    locationLabel.textAlignment = .center
    locationLabel.translatesAutoresizingMaskIntoConstraints = false
    return locationLabel
  }()
  
  private let conditionLabel: UILabel = {
    let conditionLabel = UILabel()
    conditionLabel.textAlignment = .center
    conditionLabel.translatesAutoresizingMaskIntoConstraints = false
    return conditionLabel
  }()
  
  private let temperatureLabel: UILabel = {
    let temperatureLabel = UILabel()
    temperatureLabel.textAlignment = .center
    temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
    return temperatureLabel
  }()
  
  private let weatherInfoStackView: UIStackView = {
    let weatherInfoStackView = UIStackView()
    weatherInfoStackView.axis = .vertical
    weatherInfoStackView.spacing = Constant.stackViewSpacing
    weatherInfoStackView.translatesAutoresizingMaskIntoConstraints = false
    return weatherInfoStackView
  }()
  
  private let activityIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.isHidden = true
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    return activityIndicator
  }()
  
  private var collectionViewTopConstraint: NSLayoutConstraint?
  
  let collectionView: UICollectionView = {
    // Initialize the layout
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    
    //Initialize collection view
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  init() {
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  func viewWillRotateToOrientation(_ orientation: UIInterfaceOrientation) {
    switch orientation {
    case .landscapeLeft, .landscapeRight:
      collectionViewTopConstraint?.constant = Constant.collectionViewTopPaddingLandscape
    default:
      collectionViewTopConstraint?.constant = Constant.collectionViewTopPaddingPortrait
    }
  }
  
}

// MARK: UIUpdateHelper

private typealias UIUpdateHelper = UIKitView
extension UIUpdateHelper {

  func updateCurrentWeather(_ currentWeather: CurrentWeatherJSONData) {
    locationLabel.text = currentWeather.name
    conditionLabel.text = currentWeather.weather.first?.description
    temperatureLabel.text = "current-temp".localized(args: Int(currentWeather.main.temp))
  }
  
  func updateTable() {
    tableView.reloadData()
  }
  
  func shouldShowLoading(_ shouldShow: Bool) {
    activityIndicator.isHidden = !shouldShow
    if shouldShow {
      activityIndicator.startAnimating()
    } else {
      activityIndicator.stopAnimating()
    }
  }
  
  func shouldShowUI(_ shouldShow: Bool) {
    weatherInfoStackView.isHidden = !shouldShow
    tableView.isHidden = !shouldShow
  }
  
}

// MARK: SetupHelper

private typealias SetupHelper = UIKitView
private extension SetupHelper {
  
  func setup() {
    setupWeatherInfoStackView()
    addSubview(weatherInfoStackView)
    addSubview(collectionView)
    addSubview(tableView)
    addSubview(activityIndicator)
    setupConstraints()
  }
  
  func setupWeatherInfoStackView() {
    weatherInfoStackView.addArrangedSubview(locationLabel)
    weatherInfoStackView.addArrangedSubview(conditionLabel)
    weatherInfoStackView.addArrangedSubview(temperatureLabel)
  }
  
  func setupConstraints() {
    let initialCollectionViewTopConstraint = (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) ? Constant.collectionViewTopPaddingLandscape : Constant.collectionViewTopPaddingPortrait
    collectionViewTopConstraint = collectionView.topAnchor.constraint(equalTo: topAnchor,
                                                                      constant: initialCollectionViewTopConstraint)
    collectionViewTopConstraint?.isActive = true
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: Constant.collectionViewHeight),
      
      weatherInfoStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor,
                                                constant: Constant.weatherStackViewDefaultMargin),
      weatherInfoStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: Constant.weatherStackViewDefaultMargin),
      weatherInfoStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: Constant.weatherStackViewNegatedDefaultMargin),
      
      tableView.topAnchor.constraint(equalTo: weatherInfoStackView.bottomAnchor,
                                     constant: Constant.weatherStackViewDefaultMargin),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
  
}

// MARK: Constants

private typealias Constant = UIKitView
private extension Constant {
  
  static let weatherStackViewDefaultMargin: CGFloat = 16
  static let weatherStackViewNegatedDefaultMargin: CGFloat = -16
  static let collectionViewHeight: CGFloat = 100
  static let collectionViewTopPaddingLandscape: CGFloat = 20
  static let collectionViewTopPaddingPortrait: CGFloat = 100
  static let stackViewSpacing: CGFloat = 4
  
}
