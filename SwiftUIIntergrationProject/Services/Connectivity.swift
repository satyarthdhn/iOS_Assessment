//
//  Connectivity.swift
//  SwiftUIIntergrationProject
//
//  Created by Satyarth Kumar Prasad on 29/05/24.
//

import Foundation
import Alamofire

struct Connectivity {
  static var isConnectedToInternet: Bool {
    return NetworkReachabilityManager()?.isReachable ?? false
  }
}
