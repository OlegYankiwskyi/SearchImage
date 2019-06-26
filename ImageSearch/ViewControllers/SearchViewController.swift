//
//  ViewController.swift
//  ImageSearch
//
//  Created by OlegMac on 6/25/19.
//  Copyright © 2019 Oleg_Yankivskyi. All rights reserved.
//

import UIKit

class SearchImageViewController: UIViewController {

    private let searcBar = UISearchBar()
    private let viewModel: SearchImageViewModelType
    
    init(viewModel: SearchImageViewModelType = SearchImageViewModel()) {
        super.init(nibName: "", bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
    }

    private func configureUI() {
        
        self.view.backgroundColor = .white
        self.loadSubViews()
    }
    
    private func loadSubViews() {
        
        self.configureSearcBar()
        self.configureTableView()
    }
    
    private func configureSearcBar() {
        
        self.view.addSubview(self.searcBar)
        
        let leading = NSLayoutConstraint(item: self.searcBar, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: self.searcBar, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: self.searcBar, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1, constant: 0)
        
        self.searcBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([leading, trailing, top])
        
        self.searcBar.delegate = self
    }
    
    private func configureTableView() {
        
        let tableView = UITableView()
        self.view.addSubview(tableView)
        
        let leading = NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.searcBar, attribute: .bottom, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottomMargin, multiplier: 1, constant: 0)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([leading, trailing, top, bottom])
        
        tableView.delegate = self
        
        //register cell "Cell"
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default)) //TO DO: hardcode
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: UISearchBarDelegate
extension SearchImageViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        self.viewModel.search(inputedText: text) { image, error in
            DispatchQueue.main.async {
                if let error = error {
                    
                }
            }
        }
    }
}

//MARK: UITableViewDelegate
extension SearchImageViewController: UITableViewDelegate {
    
}

//MARK: UITableViewDataSource
extension SearchImageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.countOfResults()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = self.viewModel.getSearchResult(indexPath.row)
        let cell = UITableViewCell(style: .default, reuseIdentifier: UITableViewCell.defaultReuseIdentifier)
        cell.imageView?.image = searchResult.image
        cell.textLabel?.text = searchResult.text
        return cell
    }
    
    
}
