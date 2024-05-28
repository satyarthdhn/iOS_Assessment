//
//  RootViewController.swift
//  SwiftUIIntergrationProject
//
//  Created by Satyarth Kumar Prasad on 28/05/24.
//

import UIKit

class RootViewController<T: UIView>: UIViewController {

  public var customView: T { return view as! T }
    
  override open func loadView() {
     self.view = T()
  }

}
