//
//  SearchServiceType.swift
//  ImageSearch
//
//  Created by OlegMac on 6/26/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import Foundation
import UIKit

protocol SearchServiceType {
    
    func search(searchString: String, completion: @escaping (UIImage?, Error?) -> Void)
}
