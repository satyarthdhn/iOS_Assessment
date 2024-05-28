//
//  Mockable.swift
//  SwiftUIIntergrationProject
//
//  Created by Satyarth Kumar Prasad on 28/05/24.
//

import Foundation

protocol Bundlable: AnyObject {
  var bundle: Bundle { get }
  func bundleURL(fileName: String) -> URL
}

protocol Mockable: AnyObject {
  func loadJSON<T: Decodable>(url: URL, type: T.Type) -> T
}

extension Bundlable {
  var bundle: Bundle {
    return Bundle(for: type(of: self))
  }
  
  func bundleURL(fileName: String) -> URL {
    guard let path = bundle.url(forResource: fileName, withExtension: "json") else {
      fatalError("Failed to load JSON file")
    }
    return path
  }
}

extension Mockable {
  
  func loadJSON<T: Decodable>(url: URL, type: T.Type) -> T {
    do {
      let data = try Data(contentsOf: url)
      let decodedObject = try JSONDecoder().decode(T.self, from: data)
      return decodedObject
    } catch {
      fatalError("Failed to decode JSON file")
    }
    
  }
  
}
