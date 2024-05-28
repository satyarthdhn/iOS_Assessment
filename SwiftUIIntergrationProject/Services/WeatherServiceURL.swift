//
//  WeatherServiceURL.swift
//  SwiftUIIntergrationProject
//
//  Created by Yuchen Nie on 4/10/24.
//

import Foundation
import MapKit
protocol WeatherServiceURLProtocol {
  func currentWeatherURL(location: CLLocation) -> URL?
  func forecastURL(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> URL?
}

struct WeatherServiceURL: WeatherServiceURLProtocol {
  
  /// Use this method to get the current weather URL
  ///
  /// - parameters:
  ///   - location: CLLocation
  /// - Returns: URL to retrieve current weather from OpenWeather
  func currentWeatherURL(location: CLLocation) -> URL? {
    weatherServiceUrl(path: "weather", latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
  }
  
  /// Use this method to get the 5-day weather forecast URL
  ///
  /// - parameters:
  ///   - location: CLLocation
  ///   latitude
  ///   longitudee
  /// - Returns: URL to retrieve forecast from OpenWeather
  func forecastURL(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> URL? {
    weatherServiceUrl(path: "forecast", latitude: latitude, longitude: longitude)
  }
  
  //Enter your Open weather API Key from: https://home.openweathermap.org/api_keys
  private func weatherServiceUrl(path: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.openweathermap.org"
    components.path = "/data/2.5/\(path)"
    components.queryItems = [
      URLQueryItem(name: "lat", value: "\(latitude)"),
      URLQueryItem(name: "lon", value: "\(longitude)"),
      URLQueryItem(name: "appid", value: openWeatherAPIKey),
      URLQueryItem(name: "units", value: "imperial")
    ]
    return components.url
  }
}
