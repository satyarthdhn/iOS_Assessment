//
//  WeatherServiceMock.swift
//  SwiftUIIntergrationProjectTests
//
//  Created by Satyarth Kumar Prasad on 29/05/24.
//

import Foundation
@testable import SwiftUIIntergrationProject

extension WeatherService {
  static var mock = WeatherService(networkService: NetworkServiceMock(),
                                   weatherServiceURL: WeatherServiceMockURL())
}
