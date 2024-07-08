//
//  ViewController.swift
//  moneyTracker
//
//  Created by Бадретдинов Владимир on 07.07.2024.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    
    var purchaseArray = [Purchase]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var addPurchaseButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
     
        
    }
    
    @IBAction func addPurchaseButtonPressed(_ sender: Any) {
        
    }
    
    
    
    
}

