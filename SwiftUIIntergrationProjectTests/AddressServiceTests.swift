//
//  AddressServiceTests.swift
//  SwiftUIIntergrationProjectTests
//
//  Created by Satyarth Kumar Prasad on 29/05/24.
//

import Foundation


import XCTest
@testable import SwiftUIIntergrationProject

final class AddressServiceTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testAddressValue() async throws {
    let value = try await AddressService.asyncCoordinate(from: "Hyderabad")
    XCTAssertEqual(value?.coordinate.latitude, 17.4133993)
    XCTAssertEqual(value?.coordinate.longitude, 78.4600458)
  }
  
  func testAddressFailure() async throws {
    do {
      let result = try await AddressService.asyncCoordinate(from: "vdijvsdfuyvgrweuvjf")
    } catch {
      let simpleError = error as? SimpleError
      switch simpleError {
      case .address:
        XCTAssertTrue(true)
      default:
        XCTFail()
      }
    }
  }
  
}

