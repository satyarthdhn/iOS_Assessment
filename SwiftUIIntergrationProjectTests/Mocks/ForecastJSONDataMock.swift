//
//  ForecastDisplayDataMock.swift
//  SwiftUIIntergrationProject
//
//  Created by Yuchen Nie on 4/9/24.
//

import Foundation

@testable import SwiftUIIntergrationProject
extension ForecastJSONData {
  static func createMock() -> ForecastJSONData? {
    guard let data = jsonString.data(using: .utf8),
          let current = try? JSONDecoder().decode(ForecastJSONData.self, from: data) else {
      return nil
    }
    return current
  }
}

private let jsonString = """
{
    "cod": "200",
    "message": 0,
    "cnt": 40,
    "list": [
        {
            "dt": 1712642400,
            "main": {
                "temp": 53.64,
                "feels_like": 51.94,
                "temp_min": 53.64,
                "temp_max": 55.18,
                "pressure": 1017,
                "sea_level": 1017,
                "grnd_level": 1007,
                "humidity": 69,
                "temp_kf": -0.86
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "overcast clouds",
                    "icon": "04n"
                }
            ],
            "clouds": {
                "all": 85
            },
            "wind": {
                "speed": 3.85,
                "deg": 253,
                "gust": 6.64
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2024-04-09 06:00:00"
        },
        {
            "dt": 1712653200,
            "main": {
                "temp": 54.37,
                "feels_like": 52.93,
                "temp_min": 54.37,
                "temp_max": 55.83,
                "pressure": 1017,
                "sea_level": 1017,
                "grnd_level": 1007,
                "humidity": 73,
                "temp_kf": -0.81
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "overcast clouds",
                    "icon": "04n"
                }
            ],
            "clouds": {
                "all": 89
            },
            "wind": {
                "speed": 3.15,
                "deg": 279,
                "gust": 3.27
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2024-04-09 09:00:00"
        },
        {
            "dt": 1712664000,
            "main": {
                "temp": 55.63,
                "feels_like": 54.46,
                "temp_min": 55.63,
                "temp_max": 56.62,
                "pressure": 1018,
                "sea_level": 1018,
                "grnd_level": 1008,
                "humidity": 76,
                "temp_kf": -0.55
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "overcast clouds",
                    "icon": "04d"
                }
            ],
            "clouds": {
                "all": 94
            },
            "wind": {
                "speed": 2.59,
                "deg": 310,
                "gust": 2.95
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2024-04-09 12:00:00"
        },
        {
            "dt": 1712674800,
            "main": {
                "temp": 68.74,
                "feels_like": 67.95,
                "temp_min": 68.74,
                "temp_max": 68.74,
                "pressure": 1018,
                "sea_level": 1018,
                "grnd_level": 1008,
                "humidity": 56,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "overcast clouds",
                    "icon": "04d"
                }
            ],
            "clouds": {
                "all": 100
            },
            "wind": {
                "speed": 1.68,
                "deg": 328,
                "gust": 2.66
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2024-04-09 15:00:00"
        },
        {
            "dt": 1712685600,
            "main": {
                "temp": 74.17,
                "feels_like": 73.51,
                "temp_min": 74.17,
                "temp_max": 74.17,
                "pressure": 1017,
                "sea_level": 1017,
                "grnd_level": 1007,
                "humidity": 47,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "overcast clouds",
                    "icon": "04d"
                }
            ],
            "clouds": {
                "all": 100
            },
            "wind": {
                "speed": 2.44,
                "deg": 206,
                "gust": 4.05
            },
            "visibility": 10000,
            "pop": 0,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2024-04-09 18:00:00"
        },
        {
            "dt": 1712696400,
            "main": {
                "temp": 73.62,
                "feels_like": 73.13,
                "temp_min": 73.62,
                "temp_max": 73.62,
                "pressure": 1016,
                "sea_level": 1016,
                "grnd_level": 1005,
                "humidity": 52,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "overcast clouds",
                    "icon": "04d"
                }
            ],
            "clouds": {
                "all": 100
            },
            "wind": {
                "speed": 5.39,
                "deg": 240,
                "gust": 7.83
            },
            "visibility": 10000,
            "pop": 0.21,
            "sys": {
                "pod": "d"
            },
            "dt_txt": "2024-04-09 21:00:00"
        },
        {
            "dt": 1712707200,
            "main": {
                "temp": 63.91,
                "feels_like": 64,
                "temp_min": 63.91,
                "temp_max": 63.91,
                "pressure": 1016,
                "sea_level": 1016,
                "grnd_level": 1006,
                "humidity": 85,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 501,
                    "main": "Rain",
                    "description": "moderate rain",
                    "icon": "10n"
                }
            ],
            "clouds": {
                "all": 100
            },
            "wind": {
                "speed": 7.14,
                "deg": 205,
                "gust": 17.02
            },
            "visibility": 10000,
            "pop": 1,
            "rain": {
                "3h": 3.64
            },
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2024-04-10 00:00:00"
        },
        {
            "dt": 1712718000,
            "main": {
                "temp": 60.01,
                "feels_like": 60.13,
                "temp_min": 60.01,
                "temp_max": 60.01,
                "pressure": 1016,
                "sea_level": 1016,
                "grnd_level": 1006,
                "humidity": 94,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 500,
                    "main": "Rain",
                    "description": "light rain",
                    "icon": "10n"
                }
            ],
            "clouds": {
                "all": 96
            },
            "wind": {
                "speed": 4.16,
                "deg": 222,
                "gust": 12.91
            },
            "visibility": 10000,
            "pop": 0.98,
            "rain": {
                "3h": 0.68
            },
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2024-04-10 03:00:00"
        },
        {
            "dt": 1712728800,
            "main": {
                "temp": 58.32,
                "feels_like": 58.35,
                "temp_min": 58.32,
                "temp_max": 58.32,
                "pressure": 1016,
                "sea_level": 1016,
                "grnd_level": 1006,
                "humidity": 96,
                "temp_kf": 0
            },
            "weather": [
                {
                    "id": 804,
                    "main": "Clouds",
                    "description": "overcast clouds",
                    "icon": "04n"
                }
            ],
            "clouds": {
                "all": 98
            },
            "wind": {
                "speed": 3.06,
                "deg": 252,
                "gust": 5.66
            },
            "visibility": 10000,
            "pop": 0.73,
            "sys": {
                "pod": "n"
            },
            "dt_txt": "2024-04-10 06:00:00"
        }
    ],
    "city": {
        "id": 4790534,
        "name": "Tysons Corner",
        "coord": {
            "lat": 38.9152,
            "lon": -77.2205
        },
        "country": "US",
        "population": 19627,
        "timezone": -14400,
        "sunrise": 1712659217,
        "sunset": 1712705993
    }
}
"""
