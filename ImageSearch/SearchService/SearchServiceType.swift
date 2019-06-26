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
    //TO DO: completion to typealias
    func search(searchString: String, completion: (UIImage?, Error?) -> Void)
}