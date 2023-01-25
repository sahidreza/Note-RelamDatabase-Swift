//
//  SubjectTableViewController.swift
//  Note-RelamDataBase
//
//  Created by Sahid Reza on 19/01/23.
//

import UIKit
import RealmSwift
import SwipeCellKit

class SubjectTableViewController: UITableViewController {
    
  
   
    
    @IBOutlet var subjectTableView: UITableView!
    var listofSub:Results<Catagaory>?
    var catagoryTextField = UITextField()
    let relam = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        subjectTableView.rowHeight = 60.00
       
    }
    
    
    @IBAction func pressBar(_ sender: UIBarButtonItem) {
        
        createAlert()
        
    }
    
}

// MARK: - DATA SOURCE DELEGATE & TABLE VIEW DELEGATE

extension SubjectTableViewController:SwipeTableViewCellDelegate{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(listofSub?.count)
        
        return listofSub?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //subjectTableView
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectTableView", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        
        cell.textLabel?.text = listofSub?[indexPath.row].catagoryName ?? "No Catagories Yet"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "gotoResultViewController", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            print("STep1")
            if let cataforyForDeletation = self.listofSub?[indexPath.row]{
                
                do {
                    try self.relam.write {
                        print("step3")
                    self.relam.delete(cataforyForDeletation)
                        
                    }
                }catch{
                    print(error)
                }
              
            }
           
            
           
        }

        // customize the action appearance
        deleteAction.image = UIImage(systemName: "trash")

        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        print("step2")
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        
        return options
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destionationVc = segue.destination as! ResultTableViewController
            if let indexpath = tableView.indexPathForSelectedRow{
                
                destionationVc.slectedCatagory = listofSub?[indexpath.row]

                
            }
        }
    
}



// MARK: - Alert CREATE



extension SubjectTableViewController {
    
    func createAlert(){
           
           
           let alertController = UIAlertController(title: "Note", message: "Create your note subject", preferredStyle: .alert)
           let action = UIAlertAction(title: "Save Item", style: .default){(acttion) in
               
               if self.catagoryTextField.text != " "{
                   
                   let newCatagory = Catagaory()
                   newCatagory.caragoryID = UUID()
                   newCatagory.catagoryName = self.catagoryTextField.text!
                  
                   DataBaseHelper.shared.saveData(catagory: newCatagory)
                   self.subjectTableView.reloadData()
                   
               }
               
               
               
           }
           alertController.addTextField{(textField) in
               
               textField.placeholder = "Create your own notes subject"
               self.catagoryTextField = textField
               
           }
           alertController.addAction(action)
           self.present(alertController, animated: true)
           
       }
    
}

// MARK: - Load Items

extension SubjectTableViewController{
    
    func loadItems(){
        print("Again Load")
        
        let realm = try! Realm()
        // Access all dogs in the realm
        let catagoryList = realm.objects(Catagaory.self)
        listofSub = catagoryList
        subjectTableView.reloadData()
        
        
        
    }
    
    
}



//gotoResultViewController
