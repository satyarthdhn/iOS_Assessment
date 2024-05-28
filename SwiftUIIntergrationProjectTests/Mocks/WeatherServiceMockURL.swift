//
//  WeatherServiceMockURL.swift
//  SwiftUIIntergrationProject
//
//  Created by Satyarth Kumar Prasad on 28/05/24.
//

import Foundation
import CoreLocation

@testable import SwiftUIIntergrationProject

class WeatherServiceMockURL: WeatherServiceURLProtocol, Bundlable {
  
  func currentWeatherURL(location: CLLocation) -> URL? {
    return bundleURL(fileName: "CurrentWeatherJSONDataMock")
  }
  
  func forecastURL(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> URL? {
      return bundleURL(fileName: "ForecastWeatherMockJSON")
  }
}

