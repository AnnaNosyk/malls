//
//  ModelMalls.swift
//  malls
//
//  Created by Anna Nosyk on 21.01.2021.
//import RealmSwift

import RealmSwift

class Malls: Object {
@objc dynamic var name = ""
@objc dynamic  var location: String?
@objc dynamic var imageData: Data?

    convenience init ( name: String, location: String?, imageData: Data?) {
        self.init()
        self.name = name
        self.location = location
        self.imageData = imageData
        
    }
    
    
}
