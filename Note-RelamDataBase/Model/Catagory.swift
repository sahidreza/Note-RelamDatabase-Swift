//
//  Catagory.swift
//  Note-RelamDataBase
//
//  Created by Sahid Reza on 21/01/23.
//

import Foundation
import RealmSwift

class Catagaory:Object{
    
    @Persisted var catagoryName:String
    @Persisted var caragoryID:UUID
    @Persisted var items = List<Item>()
 
    convenience init(catagoryname:String,catogryID:UUID) {
        self.init()
        self.catagoryName = catagoryname
        self.caragoryID = catogryID
    }
    
    
}
