//
//  addPurchaseViewController.swift
//  moneyTracker
//
//  Created by Бадретдинов Владимир on 07.07.2024.
//

import Foundation
import UIKit
import CoreData

class PurchaseViewController: UIViewController {
    
    @IBOutlet weak var categoryButton: UIButton!
    
    @IBOutlet weak var purchaseTextField: UITextField!
    @IBOutlet weak var costTextField: UITextField!
    
    var selectedCategory : Category? {
        didSet{
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
}
