//
//  String.swift
//  Calculator
//
//  Created by Rasyid Ridla on 19/02/23.
//

import Foundation

extension String {
  func isLessThan10() -> Bool {
    return (0...9).contains(self.toInt())
  }
  
  func getOperation() -> Int {
    switch self {
    case "+" : return 1
    case "-" : return 2
    case "x" : return 3
    case ":" : return 4
    default:
      return 5
    }
  }
  
  func toInt() -> Int {
    Int(self) ?? 10
  }
}
