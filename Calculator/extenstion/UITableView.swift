//
//  UITableView.swift
//  Calculator
//
//  Created by Rasyid Ridla on 16/02/23.
//

import UIKit

extension UITableView {
  func register(type: UITableViewCell.Type, identifier: String? = nil) {
    let cellId = String(describing: type)
    register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: identifier ?? cellId)
  }
  
  func register<T: UITableViewCell>(cell: T.Type) {
    register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
  }
  
  func dequeue<T: UITableViewCell>(for indexPath: IndexPath) -> T {
    return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
  }
}
