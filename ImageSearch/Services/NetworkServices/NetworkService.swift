//
//  NetworkService.swift
//  ImageSearch
//
//  Created by OlegMac on 7/1/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import Foundation

protocol NetworkService {
    
    func fetch(_ url: URL, _ completion: @escaping (Data?, Error?) -> Void)
}
