//
//  addPurchaseViewController.swift
//  moneyTracker
//
//  Created by Бадретдинов Владимир on 07.07.2024.
//

import Foundation
import UIKit
import CoreData

class PurchaseViewController: UIViewController, CategoryTVCDelegate {
    
    var categoriesTVC = CategoriesTableViewController()
    
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var purchaseTextField: UITextField!
    @IBOutlet weak var costTextField: UITextField!
    
    var selectedCategory : Category? {
        didSet {
            categoryButton.setTitle(selectedCategory?.name, for: .normal)
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    //MARK: - Add New Purchase
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        let (newPurchase, errorMessages) = checkErrors()
        
        if let nameError = errorMessages["nameError"] {
            purchaseTextField.placeholder = nameError
        }
        
        if let costError = errorMessages["costError"] {
            costTextField.text = ""
            costTextField.placeholder = costError
        }
        
        if let categoryError = errorMessages["categoryError"] {
            categoryButton.setTitle(categoryError, for: .normal)
        }
        
        if errorMessages.isEmpty {
            newPurchase.date = Date()
            saveContext()
        }
    }
    
    //MARK: - Model Manipulation Methods
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
//    func deletePurchase(with name: String) {
//        let fetchRequest: NSFetchRequest<Purchase> = Purchase.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
//
//        do {
//            let result = try context.fetch(fetchRequest)
//            if result.isEmpty {
//                print("No purchases found with name \(name)")
//            } else {
//                let resultData = result as [Purchase]
//                for purchase in resultData {
//                    print(purchase.name ?? "No name")
//                    context.delete(purchase)
//                    saveContext()
//                }
//            }
//        } catch {
//            print("Failed to fetch purchases: \(error)")
//        }
//    }
    
    //MARK: - Error Checking Method
    
    func checkErrors() -> (Purchase, [String: String]) {
        var errorMessages = [String: String]()
        let newPurchase = Purchase(context: self.context)
        
        if let purchaseText = purchaseTextField.text, !purchaseText.isEmpty {
            newPurchase.name = purchaseText
        } else {
            errorMessages["nameError"] = "Name a purchase"
        }
        
        if let costText = costTextField.text, !costText.isEmpty {
            if let costFloat = Float(costText) {
                newPurchase.cost = costFloat
            } else {
                errorMessages["costError"] = "Enter a valid cost"
            }
        } else {
            errorMessages["costError"] = "Enter a cost"
        }
        
        if let category = selectedCategory {
            newPurchase.associatedCategory = category
        } else {
            errorMessages["categoryError"] = "You must select a category"
        }
        
        return (newPurchase, errorMessages)
    }
    
    //MARK: - PurchaseViewController Delegate Methods
    func update(_ category: Category) {
        selectedCategory = category
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCategories", let destinationVC = segue.destination as? CategoriesTableViewController {
            destinationVC.delegate = self
        }
    }
}
