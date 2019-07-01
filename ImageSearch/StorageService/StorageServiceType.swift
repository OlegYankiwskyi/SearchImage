//
//  StorageType.swift
//  ImageSearch
//
//  Created by OlegMac on 7/1/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import Foundation
import UIKit

protocol StorageServiceType {
    
    func getElements() -> [SearchResult]
    func save(_: SearchResult)
}
