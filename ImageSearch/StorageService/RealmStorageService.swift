//
//  RealmStorage.swift
//  ImageSearch
//
//  Created by OlegMac on 7/1/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import Foundation
import RealmSwift

class RealmStorageService: StorageServiceType {
    
    func getElementsM<T>() -> [T] {
        return try! Realm().objects(T.entityType).map { $0 }
    }
    
    func save(_ obj: SearchResult) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(obj)
        }
    }
}
