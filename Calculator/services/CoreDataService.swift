//
//  CoreDataService.swift
//  Calculator
//
//  Created by Rasyid Ridla on 15/02/23.
//

import UIKit
import CoreData

class CoreDataService {
  
  static let shared = CoreDataService()
  private let entityName = "Calculator"
  
  
  func create(calculator: CalculatorModel){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let userEntity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)
    
    // entity body
    let insert = NSManagedObject(entity: userEntity!, insertInto: managedContext)
    insert.setValue(calculator.input, forKey: "input")
    insert.setValue(calculator.result, forKey: "result")
    
    do{
      // save data ke entity user core data
      try managedContext.save()
    }catch let err{
      print(err)
    }
    
  }
  
  func retrieve() -> [CalculatorModel]{
    
    var calculatorModel = [CalculatorModel]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext = appDelegate.persistentContainer.viewContext
    
    // fetch data
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    do{
      let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
      
      result.forEach{ result in
        calculatorModel.append(
          CalculatorModel(
            input: result.value(forKey: "input") as! String,
            result: result.value(forKey: "result") as! Int
          )
        )
      }
    }catch let err{
      print(err)
    }
    
    return calculatorModel
  }
  
  func delete(id: Int){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    // fetch data to delete
    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "id = id", id)
    
    do{
      let dataToDelete = try managedContext.fetch(fetchRequest)[0] as! NSManagedObject
      managedContext.delete(dataToDelete)
      
      try managedContext.save()
    }catch let err{
      print(err)
    }
    
  }
}
