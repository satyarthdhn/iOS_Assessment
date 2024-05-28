//
//  SwiftUIIntergrationProjectTests.swift
//  SwiftUIIntergrationProjectTests
//
//  Created by Yuchen Nie on 4/2/24.
//

import XCTest
@testable import SwiftUIIntergrationProject

final class UIKitViewModelTests: XCTestCase {
  
  var viewModel: UIKitViewModelProtocol!
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    viewModel = UIKitViewModel(weatherService: WeatherService(networkService: NetworkServiceMock(), 
                                                              weatherServiceURL: WeatherServiceMockURL()), currentAddress: Addresses.first ?? "")
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    viewModel = nil
  }
  
  func testCurrentWeatherFetchesSuccessfully() async throws {
    let result = try await viewModel.fetchCurrentWeather()
    XCTAssertNotNil(result)
    XCTAssertEqual(result.id, 4790534)
  }
  
  func testWeatherForecasetFetchesSuccessfully() async throws {
    let result = try await viewModel.fetchForecast()
    XCTAssertNotNil(result)
    XCTAssertEqual(result.cod, "200")
    XCTAssertEqual(result.list.count, 40)
    
  }
  
}
