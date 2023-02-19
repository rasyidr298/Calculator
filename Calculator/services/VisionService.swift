//
//  VisionService.swift
//  Calculator
//
//  Created by Rasyid Ridla on 18/02/23.
//

import Vision
import UIKit

class VisionService: NSObject {
  
  static let shared = VisionService()
  
  func setup(image: UIImage, completion: @escaping ([String]) -> Void) {
    let request = VNRecognizeTextRequest { request, error in
      guard let observations = request.results as? [VNRecognizedTextObservation] else {
        fatalError("Received invalid observations")
      }
      
      let result = observations.compactMap { observation in
        observation.topCandidates(1).first?.string
      }
      
//      print("result observations -> \(observations)")
      print("result vision -> \(result)")
      
      completion(result)
    }
    
    let requests = [request]
    request.recognitionLevel = .fast
    DispatchQueue.global(qos: .userInitiated).async {
      guard let img = image.cgImage else { return }
      let handler = VNImageRequestHandler(cgImage: img, options: [:])
      try? handler.perform(requests)
    }
  }
}

