//
//  UIView.swift
//  Calculator
//
//  Created by Rasyid Ridla on 16/02/23.
//

import UIKit


extension UIView {
  static var reuseIdentifier: String {
    return String(describing: Self.self)
  }
}
