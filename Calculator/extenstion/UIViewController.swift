//
//  UIViewController.swift
//  Calculator
//
//  Created by Rasyid Ridla on 17/02/23.
//

import UIKit

extension UIViewController {
  func showSingleAlert(title: String, message: String, button: String, completion: @escaping () -> Void) {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
      alert.addAction(UIAlertAction(title: button, style: UIAlertAction.Style.default, handler: {action in
        completion()
      }))
      self.present(alert, animated: true)
    }
  }
  
  func showDoubleAlert(title: String, message: String, leftButton: String, rightButton: String, cancel: @escaping () -> Void, save: @escaping () -> Void) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: leftButton, style: UIAlertAction.Style.destructive, handler: {action in
      cancel()
    }))
    alert.addAction(UIAlertAction(title: rightButton, style: UIAlertAction.Style.default, handler: {action in
      save()
    }))
    self.present(alert, animated: true)
  }
}
