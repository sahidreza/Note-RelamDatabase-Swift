//
//  DataBaseHelper.swift
//  Note-RelamDataBase
//
//  Created by Sahid Reza on 21/01/23.
//

import Foundation
import RealmSwift

class DataBaseHelper {
    
    static let shared = DataBaseHelper()
   
    
    func saveData(catagory:Catagaory){
        
        do{
            
            let realm = try Realm()
            try realm.write {
                realm.add(catagory)
            }
            
        }catch{
            print(error)
        }
        
        
        
    }
    
    
}
