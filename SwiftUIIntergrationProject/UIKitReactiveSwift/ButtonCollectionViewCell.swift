//
//  File.swift
//  SwiftUIIntergrationProject
//
//  Created by Satyarth Kumar Prasad on 26/05/24.
//

import UIKit

final class ButtonCollectionViewCell: UICollectionViewCell {
  
  private let button: UIButton = {
    let btn = UIButton(type: .system)
    btn.backgroundColor = .systemBlue
    btn.setTitleColor(.white, for: .normal)
    btn.layer.cornerRadius = Constant.buttonCornerRadius
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.isUserInteractionEnabled = false
    return btn
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  func setTitle(_ title: String) {
    button.setTitle(title , for: .normal)
  }
  
}

// MARK: SetupHelper

private typealias SetupHelper = ButtonCollectionViewCell
private extension SetupHelper {
  
  func setup() {
    contentView.addSubview(button)
    setupConstraints()
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      button.topAnchor.constraint(equalTo: contentView.topAnchor,
                                  constant: Constant.topConstraintConstantValue),
      button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                      constant: Constant.leftConstraintConstantValue),
      button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                       constant: Constant.rightConstraintConstantValue),
      button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                     constant: Constant.bottomConstraintConstantValue)
    ])
  }
  
}

// MARK: Constants

private typealias Constant = ButtonCollectionViewCell
private extension Constant {
  
  static let buttonCornerRadius: CGFloat = 9
  static let topConstraintConstantValue: CGFloat = 10
  static let leftConstraintConstantValue: CGFloat = 10
  static let bottomConstraintConstantValue: CGFloat = -10
  static let rightConstraintConstantValue: CGFloat = -10
  
}

