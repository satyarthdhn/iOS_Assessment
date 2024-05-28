//
//  UIKitViewModel.swift
//  SwiftUIIntergrationProject
//
//  Created by Satyarth Kumar Prasad on 28/05/24.
//

import Foundation

protocol UIKitViewModelInput {
}

protocol UIKitViewModelOutput {
}

protocol UIKitViewModelProtocol: UIKitViewModelInput, UIKitViewModelOutput, AnyObject {}

class UIKitViewModel: UIKitViewModelProtocol {
  
}
