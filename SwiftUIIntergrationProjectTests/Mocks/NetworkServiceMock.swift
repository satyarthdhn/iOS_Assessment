//
//  NetworkServiceMock.swift
//  SwiftUIIntergrationProject
//
//  Created by Satyarth Kumar Prasad on 28/05/24.
//

import Foundation
@testable import SwiftUIIntergrationProject

class NetworkServiceMock: NetworkServiceProtocol, Mockable {
  
  func request<T>(url: URL) async throws -> T where T : Decodable {
    return loadJSON(url: url, type: T.self)
  }
  
}
