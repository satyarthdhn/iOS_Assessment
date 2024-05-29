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
  let currentAddress = "8020 Towers Crescent Dr, Tysons, VA 22182"
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    viewModel = UIKitViewModel(weatherService: WeatherService(networkService: NetworkServiceMock(), 
                                                              weatherServiceURL: WeatherServiceMockURL()), currentAddress: currentAddress)
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    viewModel = nil
  }
  
  func testCurrentWeatherFetchesSuccessfully() async throws {
    let result = try await viewModel.fetchCurrentWeather(for: currentAddress)
    XCTAssertNotNil(result)
    XCTAssertEqual(result.id, 4790534)
  }
  
  func testWeatherForecasetFetchesSuccessfully() async throws {
    let result = try await viewModel.fetchForecast(for: currentAddress)
    XCTAssertNotNil(result)
    XCTAssertEqual(result.cod, "200")
    XCTAssertEqual(result.list.count, 40)
    
  }
  
  //This case can be verified if there is no internet connection, otherwise this test case will pass.
  //Note: If you pass network cached address in viewmodel. It might return value even if no network condition. SO change to new address after switching off internet
  func testCurrentWeatherNoInternetFailure() async {
    if !Connectivity.isConnectedToInternet {
      do {
        let result = try await viewModel.fetchCurrentWeather(for: currentAddress)
      } catch {
        let simpleError = error as? SimpleError
        switch simpleError {
        case .noInternet:
          XCTAssertTrue(true)
        default:
          XCTFail()
        }
      }
      
    } else {
      XCTAssertTrue(true)
    }
  }
  
  //This case can be verified if there is no internet connection, otherwise this test case will pass.
  //Note: If you pass network cached address in viewmodel. It might return value even if no network condition. SO change to new address after switching off internet
  func testWeatherForecastNoInternetFailure() async {
    if !Connectivity.isConnectedToInternet {
      do {
        let result = try await viewModel.fetchForecast(for: currentAddress)
      } catch {
        let simpleError = error as? SimpleError
        switch simpleError {
        case .noInternet:
          XCTAssertTrue(true)
        default:
          XCTFail()
        }
      }
      
    } else {
      XCTAssertTrue(true)
    }
  }
  
  func testCurrentWeatherDataParseFailure() async {
    do {
      let result = try await viewModel.fetchCurrentWeather(for: currentAddress)
    } catch {
      let simpleError = error as? SimpleError
      switch simpleError {
      case .noInternet:
        XCTAssertTrue(true)
      default:
        XCTFail()
      }
    }
    
  }
  
}
