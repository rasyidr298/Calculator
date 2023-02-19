//
//  CalculatorCell.swift
//  Calculator
//
//  Created by Rasyid Ridla on 15/02/23.
//

import UIKit

class CalculatorCell: UITableViewCell {
  
  static let CELL_HEIGHT: CGFloat = 50
  @IBOutlet weak var lblOperation: UILabel!
  
  func configureView(calculator: CalculatorModel) {
    lblOperation.text = "\(calculator.input) = \(calculator.result)"
  }
    
}
