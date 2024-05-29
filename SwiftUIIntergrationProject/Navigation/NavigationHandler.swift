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
    let weatherService = WeatherService(networkService: NetworkService(),
                                        weatherServiceURL: WeatherServiceURL())
    let viewModel = UIKitViewModel(weatherService: weatherService,
                                   currentAddress: currentAddress)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "M/dd/yy h:mm a"
    dateFormatter.timeZone = .current
    let controller = UIKitController(viewModel: viewModel,
                                     addresses: Addresses,
                                     dateFormatter: dateFormatter)
    navigationController?.pushViewController(controller, animated: true)
  }
  
  private func navigateSwiftUIView() {
    let controller = SwiftUIController()
    navigationController?.pushViewController(controller, animated: true)
  }
}
