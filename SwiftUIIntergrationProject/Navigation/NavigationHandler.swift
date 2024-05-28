//
//  NavigationHandler.swift
//  SwiftUIIntergrationProject
//
//  Created by Yuchen Nie on 4/4/24.
//

import Foundation
import UIKit

extension UIViewController {
  func handle(action: DemoType) {
    switch action {
    case .uiKit:
      navigateUIKitView()
    case .swiftUI:
      navigateSwiftUIView()
    }
  }
  
  private func navigateUIKitView() {
    let currentAddress = Addresses.first ?? ""
    let weatherService = WeatherService(networkService: NetworkService(), weatherServiceURL: WeatherServiceURL())
    let viewModel = UIKitViewModel(weatherService: weatherService,
                                   currentAddress: currentAddress)
    let controller = UIKitController(viewModel: viewModel)
    navigationController?.pushViewController(controller, animated: true)
  }
  
  private func navigateSwiftUIView() {
    let controller = SwiftUIController()
    navigationController?.pushViewController(controller, animated: true)
  }
}
