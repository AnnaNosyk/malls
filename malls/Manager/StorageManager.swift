//
//  StorageManager.swift
//  malls
//
//  Created by Anna Nosyk on 26.01.2021.
//

import RealmSwift

let realm = try! Realm()

//saving items in Database
class StorageManager {
    
    static func saveObject(_ mall: Malls) {
        
        try! realm.write {
            realm.add(mall)
        }
    }
    // delete from Database
    static func deleteObject(_ mall: Malls) {
        
        try! realm.write {
            realm.delete(mall)
        }
    }
}
