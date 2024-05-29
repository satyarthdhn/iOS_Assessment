//
//  UIKitViewModel.swift
//  SwiftUIIntergrationProject
//
//  Created by Satyarth Kumar Prasad on 28/05/24.
//

import Foundation

protocol UIKitViewModelInput {
  func viewDidLoad()
  func fetchCurrentWeather(for address: String) async throws -> CurrentWeatherJSONData
  func fetchForecast(for address: String) async throws -> ForecastJSONData
  func updateCurrentAddress(to updatedAddress: String)
}

protocol UIKitViewModelOutput {
  var currentWeatherData: Listenable<CurrentWeatherJSONData?> { get }
  var weatherForecastData: Listenable<ForecastJSONData?> { get }
  var error: Listenable<String> { get }
}

typealias UIKitViewModelProtocol = UIKitViewModelInput & UIKitViewModelOutput

final class UIKitViewModel: UIKitViewModelProtocol {
  
  let currentWeatherData: Listenable<CurrentWeatherJSONData?> = Listenable(nil)
  let weatherForecastData: Listenable<ForecastJSONData?> = Listenable(nil)
  let error: Listenable<String> = Listenable("")
  private var currentAddress: String
  private let weatherService: WeatherServiceProtocol
  
  init(weatherService: WeatherServiceProtocol, currentAddress: String) {
    self.currentAddress = currentAddress
    self.weatherService = weatherService
  }
  
  func viewDidLoad() {
    setupData()
  }
  
  func fetchCurrentWeather(for address: String) async throws -> CurrentWeatherJSONData {
    return try await weatherService.getCurrentWeather(of: address)
  }
  
  func fetchForecast(for address: String) async throws -> ForecastJSONData {
    return try await weatherService.getWeatherForecast(of: address)
  }
  
  func updateCurrentAddress(to updatedAddress: String) {
    currentAddress = updatedAddress
    setupCurrentWeather()
    setupForecast()
  }
  
}

// MARK: SetupHelper

private typealias SetupHelper = UIKitViewModel
private extension SetupHelper {
  
  func setupData() {
    setupCurrentWeather()
    setupForecast()
  }

  func setupForecast() {
    Task {
      do {
        let forecast = try await fetchForecast(for: currentAddress)
        weatherForecastData.value = forecast
      } catch {
        parseError(error as? SimpleError)
      }
    }
  }
  
  func setupCurrentWeather() {
    Task {
      do {
        let currentWeather = try await fetchCurrentWeather(for: currentAddress)
        currentWeatherData.value = currentWeather
      } catch {
        parseError(error as? SimpleError)
      }
    }
  }
  
  func parseError(_ simpleError: SimpleError?) {
    guard let simpleError else { return }
    switch simpleError {
    case .address:
      error.value = "address-not-correct".localized
    case .dataLoad:
      error.value = "failed-to-load".localized
    case .dataParse:
      error.value = "failed-to-parse".localized
    case .noInternet:
      error.value = "no-internet".localized
    }
  }
  
}
