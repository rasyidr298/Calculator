//
//  MainVC.swift
//  Calculator
//
//  Created by Rasyid Ridla on 15/02/23.
//

import UIKit

class MainVC: UIViewController {
  
  @IBOutlet weak var tblCalculator: UITableView!
  var imagePicker = UIImagePickerController()
  private var calculators = [CalculatorModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureView()
  }
  
  @IBAction func didTapAdd(_ sender: Any) {
    self.showDoubleAlert(
      title: "select sources",
      message: "Select the source to get the photo to be scanned",
      leftButton: "Camera",
      rightButton: "Album",
      cancel: {
        self.toImagePickerVC(isCamera: true)
      }, save: {
        self.toImagePickerVC(isCamera: false)
      })
  }
  
  func configureView() {
    self.tblCalculator.delegate = self
    self.tblCalculator.dataSource = self
    self.tblCalculator.register(type: CalculatorCell.self)
    
    fetchCoreData()
  }
  
  func visionDataProcess(string: String) {
    if Array(string).count == 3 {
      let first = Array(string)[0].description
      let second = Array(string)[1].description
      let third = Array(string)[2].description
      
      if first.isLessThan10() && third.isLessThan10() {
        let operationResult = mathOperation(
          num1: first.toInt(),
          num2: third.toInt(),
          operation: second.getOperation()
        )
        
        self.showSingleAlert(
          title: "Vision Result",
          message: "\(first) \(second) \(third) = \(operationResult)",
          button: "Ok"
        ) {
          self.fetchCoreData()
        }
        
        DispatchQueue.main.async {
          CoreDataService.shared.create(
            calculator: CalculatorModel(
              input: "\(first) \(second) \(third)",
              result: operationResult)
          )
        }
      }else {
        self.showSingleAlert(
          title: "Incompatible format",
          message: "result -> \(string)",
          button: "Ok",
          completion: {}
        )
      }
    }else {
      self.showSingleAlert(
        title: "Incompatible format",
        message: "result -> \(string)",
        button: "Ok", completion: {}
      )
    }
    
  }
  
}

//Camera
extension MainVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  func toImagePickerVC(isCamera: Bool) {
    if isCamera {
      imagePicker.sourceType = .camera
    }else {
      imagePicker.sourceType = .savedPhotosAlbum
    }
    imagePicker.allowsEditing = true
    imagePicker.delegate = self
    present(imagePicker, animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    picker.dismiss(animated: true)
    guard let image = info[.editedImage] as? UIImage else { return }
    
    VisionService.shared.setup(image: image, completion: { [weak self] result in
      guard let string = result.first else {
        self?.showSingleAlert(
          title: "Vision Result",
          message: "empty result",
          button: "Ok"
        ) {}
        return
      }
      
      self?.visionDataProcess(string: string)
    })
  }
}

//tableView
extension MainVC: UITableViewDataSource, UITableViewDelegate {
  func fetchCoreData() {
    calculators.removeAll()
    calculators.append(contentsOf: CoreDataService.shared.retrieve())
    tblCalculator.reloadData()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return calculators.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    CalculatorCell.CELL_HEIGHT
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(for: indexPath) as CalculatorCell
    cell.configureView(calculator: calculators[indexPath.row])
    
    return cell
  }
}
