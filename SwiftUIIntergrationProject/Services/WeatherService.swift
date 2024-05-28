import Foundation
import Combine
import MapKit

protocol WeatherServiceProtocol {
  static func getAddressLocation(of address: String) async throws -> CLLocation?
  func getCurrentWeather(of address: String) async throws -> CurrentWeatherJSONData
  func get5DayWeatherForecast(of address: String) async throws -> ForecastJSONData
}

struct WeatherService: WeatherServiceProtocol {
  
  private let networkService: NetworkServiceProtocol
  private let weatherServiceURL: WeatherServiceURLProtocol
  
  init(networkService: NetworkServiceProtocol, 
       weatherServiceURL: WeatherServiceURLProtocol) {
    self.networkService = networkService
    self.weatherServiceURL = weatherServiceURL
  }

  static func getAddressLocation(of address: String) async throws -> CLLocation? {
    return try await AddressService.asyncCoordinate(from: address)
  }
  
  func getCurrentWeather(of address: String) async throws -> CurrentWeatherJSONData {
    guard let cllocation = try await WeatherService.getAddressLocation(of: address), let url = weatherServiceURL.currentWeatherURL(location: cllocation) else { throw SimpleError.address }
    let result: CurrentWeatherJSONData = try await networkService.request(url: url)
    return result
  }
  
  func get5DayWeatherForecast(of address: String) async throws -> ForecastJSONData {
    guard let cllocation = try await WeatherService.getAddressLocation(of: address), let url = weatherServiceURL.forecastURL(latitude: cllocation.coordinate.latitude, longitude: cllocation.coordinate.longitude) else { throw SimpleError.address }
    let result: ForecastJSONData = try await networkService.request(url: url)
    return result
  }
}

extension WeatherService {
  static var live = WeatherService(networkService: NetworkService(),
                                   weatherServiceURL: WeatherServiceURL())
}
