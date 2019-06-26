//
//  ImageSearchError.swift
//  ImageSearch
//
//  Created by OlegMac on 6/26/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import Foundation

enum SearchImageError: Error {
    case textEmpty
    case imageNotFound
    case serverError
    case error
    
    var localizedDescription: String {
        switch self {

        case .textEmpty:
            return "Could you enter text?"
        case .imageNotFound:
            return "We can not find any image."
        case .serverError:
            return "Could you try later?"
        case .error:
            return "Something went wrong."
        }
    }
    
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
