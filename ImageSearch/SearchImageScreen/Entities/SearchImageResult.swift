//
//  SearchImageResult.swift
//  ImageSearch
//
//  Created by OlegMac on 6/26/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import Foundation
import UIKit

struct SearchImageResult {
    var image: UIImage
    var text: String
    
    init(_ image: UIImage, text: String) {
        self.image = image
        self.text = text
    }
    
    init() {
        self.image = UIImage()
        self.text = .empty
    }
}
