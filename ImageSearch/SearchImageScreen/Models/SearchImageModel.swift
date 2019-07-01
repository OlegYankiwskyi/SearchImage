//
//  SearchImageModel.swift
//  ImageSearch
//
//  Created by OlegMac on 6/26/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import Foundation
import UIKit

class SearchImageModel: SearchImageModelType {
    
    private let searchService: SearchServiceType
    private let storageService: StorageServiceType
    
    init(searchService: SearchServiceType = FlickerSearchService(), storageService: StorageServiceType = RealmStorageService()) {
        
        self.searchService = searchService
        self.storageService = storageService
    }
    
    func search(inputedText: String, completion: @escaping (SearchImageError?) -> Void) {
        if inputedText.isEmpty { completion(SearchImageError.textEmpty) }
        
        self.searchService.search(searchString: inputedText) { [weak self] image, error in
            guard let `self` = self else {
                completion(.unknown)
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
                completion(.imageNotFound)
            }
        }
    }
    
    func countOfResults() -> Int {
        return self.getElements().count
    }
    
    func getSearchResult(_ at: Int) -> SearchResult {
        return self.getElements()[safe: at] ?? SearchResult()
    }
    
    private func getElements() -> [SearchResult] {
        return storageService.getElements().reversed()
    }
    
    private func save(_ image: UIImage, text: String) {
        self.storageService.save(SearchResult(image, text: text))
    }
}

