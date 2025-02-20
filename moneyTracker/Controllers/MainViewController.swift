//
//  ViewController.swift
//  moneyTracker
//
//  Created by Бадретдинов Владимир on 07.07.2024.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PurchaseVCDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPurchaseVC",
           let destinationVC = segue.destination as? PurchaseViewController {
            destinationVC.delegate = self
            print("Delegate set in MainViewController")
        }
    }
    
    func update(_ newPurchase: Purchase) {
        DispatchQueue.main.async {
            self.purchases.append(newPurchase)
            print("Purchase appended: \(newPurchase.name ?? "No name")")
            self.purchasesTableView.reloadData()
            print("Purchases reloaded, count: \(self.purchases.count)")

        }
    } 
    
    
    var purchases = [Purchase]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var purchasesTableView: UITableView!
    @IBOutlet weak var addPurchaseButton: UIButton!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        purchasesTableView.delegate = self
        purchasesTableView.dataSource = self
        
        purchasesTableView.register(
            UINib(nibName: "PurchaseCell", bundle: Bundle.main),
            forCellReuseIdentifier: "PurchaseCell"
        )
        
        loadPurchases()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    @IBAction func addPurchaseButtonPressed(_ sender: Any) {
        
    }
    
    //MARK: - TableView Datasource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseCell", for: indexPath) as! PurchaseCell
        cell.nameLabel.text = purchases[indexPath.row].name
        cell.costLabel.text = String(purchases[indexPath.row].cost)
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let selectedCategory = categories[indexPath.row]
        //        delegate?.update(selectedCategory)
        //        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Data Manipulation Methods
    
    func loadPurchases() {
        let request: NSFetchRequest<Purchase> = Purchase.fetchRequest()
        do {
            purchases = try context.fetch(request)
        } catch {
            print("Error loading purchases \(error)")
        }
    }
}
