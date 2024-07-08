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
            categoryButton.titleLabel?.text = selectedCategory?.name
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
    }
    
    //MARK: - Add New Purchase
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        guard let purchaseText = purchaseTextField.text, !purchaseText.isEmpty else {
            purchaseTextField.placeholder = "Name a purchase"
            return
        }
        
        guard let costText = costTextField.text, !costText.isEmpty else {
            costTextField.placeholder = "Price?"
            return
        }
        
        guard let category = selectedCategory else {
            categoryButton.setTitle("You must select a category", for: .normal)
            return
        }
        
//        var purchaseTextFieldCopy = UITextField()
//        var costTextFieldCopy = UITextField()
//        
//        
//        let newPurchase = Purchase(context: self.context)
//        newPurchase.name = textField.text!
//        newPurchase.parentCategory = self.selectedCategory
//        self.itemArray.append(newItem)
//        
//        self.saveItems()
    }
}

