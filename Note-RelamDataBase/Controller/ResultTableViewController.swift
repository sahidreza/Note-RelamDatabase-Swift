//
//  ResultTableViewController.swift
//  Note-RelamDataBase
//
//  Created by Sahid Reza on 23/01/23.
//

import UIKit
import RealmSwift

class ResultTableViewController: UITableViewController {
    
    
    
    var slectedCatagory:Catagaory? {
        
        didSet{
            loadItems()
        }
    }
    
    var todoItems:Results<Item>?
    var itemTextField = UITextField()
    var relam = try! Realm()
    
    @IBOutlet var resultTableViewData: UITableView!
    
    @IBOutlet weak var resultsSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsSearchBar.delegate = self
        
    }
    
    @IBAction func preeBarButton(_ sender: UIBarButtonItem) {
        
        createAlert()
    }
}

// MARK: - TABLE VIEW DATA SOURCE DELEGATE & TABLE VIEW DLEGATE

extension ResultTableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsCell", for: indexPath)
        cell.textLabel?.text = todoItems?[indexPath.row].title ?? "The is no Items"
        return cell
        
    }
    
}

// MARK: - ALERT CREATION

extension ResultTableViewController {
    
    func createAlert(){
           
           
           let alertController = UIAlertController(title: "Note", message: "Create your note subject", preferredStyle: .alert)
           let action = UIAlertAction(title: "Save Item", style: .default){(acttion) in
               
               if self.itemTextField.text != " "{
                   
                   if let currentCatagory = self.slectedCatagory{
                       do{
                           try self.relam.write{
                               let newItem = Item()
                               newItem.title = self.itemTextField.text!
                               newItem.id = UUID()
                               currentCatagory.items.append(newItem)
                           }
                           
                       }catch{
                           print(error)
                       }
                       
                   }
                   
                   self.resultTableViewData.reloadData()
                   
                   
                   
               }
               
               
               
           }
           alertController.addTextField{(textField) in
               
               textField.placeholder = "Create your own notes subject"
               self.itemTextField = textField
               
           }
           alertController.addAction(action)
           self.present(alertController, animated: true)
           
       }
    
    
    
}

// MARK: - LOAD ITEMS

extension ResultTableViewController {
    
    func loadItems(){
        
        todoItems = slectedCatagory?.items.sorted(byKeyPath: "title",ascending: true)
       
       
        
    }
    
}


// MARK: - Search Bar Mehods

extension ResultTableViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title",ascending: true)
        resultTableViewData.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            resultTableViewData.reloadData()
            DispatchQueue.main.async {
                print("hello")
                self.resultsSearchBar.resignFirstResponder()
            }
        }
    }
    
}
