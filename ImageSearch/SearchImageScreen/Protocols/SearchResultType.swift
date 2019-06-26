//
//  SearchResultType.swift
//  ImageSearch
//
//  Created by OlegMac on 6/26/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import Foundation
import UIKit

protocol SearchResultType {
    var image: UIImage { get }
    var text: String { get }
}
