//
//  NetworkService.swift
//  SwiftUIIntergrationProject
//
//  Created by Satyarth Kumar Prasad on 28/05/24.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
  func request<T: Decodable>(url: URL) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
  private let session: URLSession
  
  init(session: URLSession = URLSession.shared) {
    self.session = session
  }
  
  func request<T: Decodable>(url: URL) async throws -> T {
    let (data, response) = try await session.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
      throw SimpleError.dataLoad("invalid response")
    }
    
    do {
      let decodedObject = try JSONDecoder().decode(T.self, from: data)
      return decodedObject
    } catch let decodingError {
      throw SimpleError.dataParse("parsing failed")
    }
  }
}
