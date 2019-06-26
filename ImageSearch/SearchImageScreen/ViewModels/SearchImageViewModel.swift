//
//  SearchViewModel.swift
//  ImageSearch
//
//  Created by OlegMac on 6/26/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import Foundation
import UIKit

class SearchImageViewModel: SearchImageViewModelType {
    
    private let searchService: SearchServiceType
    private var searchResults = Array<SearchImageResult>()
    
    init(searchService: SearchServiceType = FlickerSearchService()) {
        self.searchService = searchService
    }
    
    func search(inputedText: String, completion: @escaping (SearchImageError?) -> Void) {
        if inputedText.isEmpty { completion(SearchImageError.textEmpty) }
        
        self.searchService.search(searchString: inputedText) { [weak self] image, error in
            guard let `self` = self else { return }
            
            if let error = error {
                completion(SearchImageError(error))
            }
            else if let image = image {
                //TO DO: realm save
                self.searchResults.append(SearchImageResult(image, text: inputedText))
                completion(nil)
            }
            else {
                completion(SearchImageError.imageNotFound)
            }
        }
    }
    
    func countOfResults() -> Int {
        return self.searchResults.count
    }
    
    func getSearchResult(_ at: Int) -> SearchImageResult {
        return self.searchResults[safe: at] ?? SearchImageResult()
    }
}

