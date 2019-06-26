//
//  SearchViewModel.swift
//  ImageSearch
//
//  Created by OlegMac on 6/26/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class SearchImageViewModel: SearchImageViewModelType {
    
    private let searchService: SearchServiceType
    
    init(searchService: SearchServiceType = FlickerSearchService()) {
        self.searchService = searchService
    }
    
    func search(inputedText: String, completion: @escaping (SearchImageError?) -> Void) {
        if inputedText.isEmpty { completion(SearchImageError.textEmpty) }
        
        self.searchService.search(searchString: inputedText) { [weak self] image, error in
            guard let `self` = self else {
                completion(.error)
                return
            }
            if let error = error {
                completion(SearchImageError(error))
            }
            else if let image = image {
                self.save(image, text: inputedText)
                completion(nil)
            }
            else {
                completion(SearchImageError.imageNotFound)
            }
        }
    }
    
    func countOfResults() -> Int {
        return try! Realm().objects(SearchResult.self).count
    }
    
    func getSearchResult(_ at: Int) -> SearchResult {
        return try! Realm().objects(SearchResult.self)[safe: at] ?? SearchResult()
    }
    
    private func save(_ image: UIImage, text: String) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(SearchResult(image, text: text))
        }
    }
}

