//
//  SearchServiceError.swift
//  ImageSearch
//
//  Created by OlegMac on 6/26/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import Foundation

enum SearchServiceError: Error {
    case baseError //TO DO: rename
    case noData
    case parseJSON
    case noPhotosFound
    case urlNotValid
}
