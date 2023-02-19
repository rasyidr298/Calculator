//
//  OperationUtils.swift
//  Calculator
//
//  Created by Rasyid Ridla on 19/02/23.
//

import Foundation

func mathOperation(num1: Int, num2: Int, operation: Int) -> Int {
  switch operation {
  case 1 : return num1 + num2
  case 2 : return num1 - num2
  case 3 : return num1 * num2
  case 4 : return num1 / num2
  default:
    return 0
  }
}
