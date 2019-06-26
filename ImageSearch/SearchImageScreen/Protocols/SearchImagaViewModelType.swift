//
//  SearchImagaViewModelType.swift
//  ImageSearch
//
//  Created by OlegMac on 6/26/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import Foundation
import UIKit

protocol SearchImageViewModelType {
    func countOfResults() -> Int
    func getSearchResult(_ at: Int) -> SearchImageResult
    func search(inputedText: String, completion: @escaping (SearchImageError?) -> Void)
}