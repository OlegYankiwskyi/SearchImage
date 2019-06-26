//
//  SearchViewModel.swift
//  ImageSearch
//
//  Created by OlegMac on 6/26/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import Foundation
import UIKit

enum SearchImageError: Error {
    case textEmpty
    case imageNotFound
    case serverError
    case error
    
    init(_ error: Error) {
        if let error = error as? SearchServiceError {
            switch error {
                
            case .noData, .noPhotosFound:
                self = .imageNotFound
            default:
                self = .serverError
            }
        }
        else {
            self = .error
        }
    }
}

class SearchImageViewModel: SearchImageViewModelType {
    
    private let searchService: SearchServiceType
    
    init(searchService: SearchServiceType = FlickerSearchService()) {
        self.searchService = searchService
    }
    
    func search(inputedText: String, completion: (UIImage?, Error?) -> Void) {
        if inputedText.isEmpty { completion(nil, SearchImageError.textEmpty) }
        
        self.searchService.search(searchString: inputedText) { image, error in
            if let error = error {
                completion(nil, SearchImageError(error))
            }
            else if let image = image {
                //TO DO: realm save
                completion(image, nil)
            }
            else {
                completion(nil, SearchImageError.imageNotFound)
            }
        }
    }
    
    func countOfResults() -> Int {
        return 0
    }
    
    func getSearchResult(_ at: Int) -> SearchResult{
        return SearchResult(image: UIImage(), text: .empty)
    }
}

struct SearchResult {
    var image: UIImage
    var text: String
}
