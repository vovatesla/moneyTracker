//
//  CategoriesViewController.swift
//  moneyTracker
//
//  Created by Бадретдинов Владимир on 07.07.2024.
//

import Foundation
import UIKit
import CoreData

protocol CatrgoryTVCDelegate {
    func update(_ category: Category)
}

class CategoriesTableViewController: UITableViewController {
    
    var delegate: CatrgoryTVCDelegate?
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row]
        delegate?.update(selectedCategory)
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Data Manipulation Methods
    
    //    func saveCategories() {
    //        do {
    //            try context.save()
    //        } catch {
    //            print("Error saving category \(error)")
    //        }
    //        tableView.reloadData()
    //    }
    
    func loadCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }
        tableView.reloadData()
    }
}
