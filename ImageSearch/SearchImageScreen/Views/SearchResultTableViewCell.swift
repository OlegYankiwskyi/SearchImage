//
//  SearchResultTableViewCell.swift
//  ImageSearch
//
//  Created by OlegMac on 6/27/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    static let height: CGFloat = 100
    
    var searchResult: SearchResult? {
        didSet {
            self.searchImageView.image = searchResult?.image
            self.searchLabel.text = searchResult?.text
        }
    }
    
    private let searchImageView: UIImageView = {
        let imgView = UIImageView(image: nil)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private let searchLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()

    
    init() {
        super.init(style: .default, reuseIdentifier: nil)
        
        self.addSubview(self.searchImageView)
        self.addSubview(self.searchLabel)
        
        self.searchImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        self.searchLabel.anchor(top: self.topAnchor, left: self.searchImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: self.frame.size.width / 2, height: 0, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
