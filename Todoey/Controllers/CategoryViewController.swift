//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Gerold Kölle on 01.05.19.
//  Copyright © 2019 Gerold Kölle. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {
    
    
    let realm = try! Realm()
    
//    var categories = [Category]()
    var categories: Results<Category>?

//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }
    
    //MARK: – TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
//        let category = categories[indexPath.row]
//
//        cell.textLabel?.text = category.name
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
        
    }
    
    //MARK: - Add New Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        var textField = UITextField()
    
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
    
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
        
//            let newCategory = Category(context: self.context)
            
            let newCategory = Category()
            
            newCategory.name = textField.text!
        
//            self.categories.append(newCategory)
            
//            self.saveCategories()
            self.save(category: newCategory)
        
        }
    
        alert.addTextField { (alertTextfield) in
            
            alertTextfield.placeholder = "Create new category"
            textField = alertTextfield
        
        }
    
        alert.addAction(action)
    
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
        destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    
//    func saveCategories() {
    
    func save(category: Category) {
        
        do {
//            try context.save()
            try realm.write {
                realm.add(category)
            }
        } catch {
//            print("Error saving context \(error)")
            print("Error writing realm \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategories() {

//        let request: NSFetchRequest<Category> = Category.fetchRequest()
//
//        do {
//            categories = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//
//        tableView.reloadData()
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()

    }
    
}

    

    

