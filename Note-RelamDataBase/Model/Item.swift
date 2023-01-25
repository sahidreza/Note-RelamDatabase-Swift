//
//  Item.swift
//  Note-RelamDataBase
//
//  Created by Sahid Reza on 21/01/23.
//

import Foundation
import RealmSwift

class Item:Object{
  
     @Persisted var title:String = ""
     @Persisted var id: UUID = UUID()
     @Persisted var bool:Bool = false
  
    @Persisted var parentCatatagory = LinkingObjects(fromType: Catagaory.self, property: "items")
    
}
