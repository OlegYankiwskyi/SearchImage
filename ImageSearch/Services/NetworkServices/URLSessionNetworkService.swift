//
//  URLSessionNetworkService.swift
//  ImageSearch
//
//  Created by OlegMac on 7/1/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import Foundation
import UIKit

class URLSessionNetworkService: NetworkService {
    
    func fetch(_ url: URL, _ completion: @escaping (Data?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            completion(data, error)
        }
        
        task.resume()
    }
}
