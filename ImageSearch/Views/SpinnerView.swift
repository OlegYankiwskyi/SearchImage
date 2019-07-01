//
//  SpinnerView.swift
//  ImageSearch
//
//  Created by OlegMac on 6/27/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import Foundation
import UIKit

class SpinnerViewController: UIViewController {
    private var spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    init(on baseVC: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        
        baseVC.addChild(self)
        self.view.frame = baseVC.view.frame
        baseVC.view.addSubview(self.view)
        self.didMove(toParent: baseVC)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
