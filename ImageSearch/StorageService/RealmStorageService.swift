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
    
    func getElements() -> [SearchResult] {
        return try! Realm().objects(SearchResult.self).reversed()
    }
    
    func save(_ obj: SearchResult) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(obj)
        }
    }
}
