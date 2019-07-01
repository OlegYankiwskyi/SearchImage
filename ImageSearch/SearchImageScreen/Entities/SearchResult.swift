//
//  SearchImageResult.swift
//  ImageSearch
//
//  Created by OlegMac on 6/26/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class SearchResult: Object {
    
    @objc dynamic private var imageData: Data = Data()
    @objc dynamic var text: String = .empty
    
    var image: UIImage {
        return UIImage(data: self.imageData) ?? UIImage()
    }
    
    convenience init(_ image: UIImage, text: String) {
        self.init()
        
        self.imageData = image.pngData() ?? self.imageData
        self.text = text
    }
}
