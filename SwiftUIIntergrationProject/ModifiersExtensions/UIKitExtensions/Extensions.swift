//
//  Extensions.swift
//  SwiftUIIntergrationProject
//
//  Created by Satyarth Kumar Prasad on 28/05/24.
//

import UIKit

extension UICollectionViewCell {
  class var identifier: String {
    return String(describing: self)
  }
}

extension UITableViewCell {
  class var identifier: String {
    return String(describing: self)
  }
}

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "\(self)_comment")
  }
  
  func localized(args: CVarArg...) -> String {
    return String(format: localized, arguments: args)
  }
}

extension UIViewController {
  
  func showAlert(title: String, msg: String) {
    let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(action)
    self.present(alert, animated: true, completion: nil)
  }
  
}

extension UIFont {
  static let systemMedium = UIFont.boldSystemFont(ofSize: 24)
}

