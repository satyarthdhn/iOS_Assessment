//
//  CurrentWeatherDisplayDataMock.swift
//  SwiftUIIntergrationProject
//
//  Created by Yuchen Nie on 4/9/24.
//

import Foundation

@testable import SwiftUIIntergrationProject
extension CurrentWeatherJSONData {
  static func createMock() -> CurrentWeatherJSONData? {
    guard let data = jsonString.data(using: .utf8),
          let current = try? JSONDecoder().decode(CurrentWeatherJSONData.self, from: data) else {
      return nil
    }
    return current
  }
}


private let jsonString = """
{
  "coord": {
    "lon": -77.2206,
    "lat": 38.9151
  },
  "weather": [
    {
      "id": 803,
      "main": "Clouds",
      "description": "broken clouds",
      "icon": "04n"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 59.65,
    "feels_like": 57.85,
    "temp_min": 52.09,
    "temp_max": 63.93,
    "pressure": 1017,
    "humidity": 54
  },
  "visibility": 10000,
  "wind": {
    "speed": 3.44,
    "deg": 150
  },
  "clouds": {
    "all": 75
  },
  "dt": 1712628961,
  "sys": {
    "type": 2,
    "id": 2005700,
    "country": "US",
    "sunrise": 1712572908,
    "sunset": 1712619536
  },
  "timezone": -14400,
  "id": 4790534,
  "name": "Tysons Corner",
  "cod": 200
}
"""
