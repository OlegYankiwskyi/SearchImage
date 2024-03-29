//
//  SearchImageModelType.swift
//  ImageSearch
//
//  Created by OlegMac on 6/26/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import Foundation
import UIKit

protocol SearchImageModelType {
    
    func countOfResults() -> Int
    func getSearchResult(_: Int) -> SearchResult
    func search(inputedText: String, completion: @escaping (SearchImageError?) -> Void)
}
