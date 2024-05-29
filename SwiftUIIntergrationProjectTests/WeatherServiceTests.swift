//
//  AddressServiceTests.swift
//  SwiftUIIntergrationProjectTests
//
//  Created by Satyarth Kumar Prasad on 29/05/24.
//

import Foundation


import XCTest
@testable import SwiftUIIntergrationProject

final class WeatherServiceTests: XCTestCase {
  
  let address = "8020 Towers Crescent Dr, Tysons, VA 22182"
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testCurrentWeatherSuccess() async throws {
    let value = try await WeatherService(networkService: NetworkServiceMock(),
                                         weatherServiceURL: WeatherServiceMockURL()).getCurrentWeather(of: address)
    XCTAssertNotNil(value)
    XCTAssertEqual(value.id, 4790534)

  }
  
}

