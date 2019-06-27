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
    private let searchResultsTableView = UITableView()
    private let viewModel: SearchImageModelType
    
    init(viewModel: SearchImageModelType = SearchImageModel()) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        self.loadSubViews()
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
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
        
        self.view.addSubview(self.searchResultsTableView)
        
        let leading = NSLayoutConstraint(item: self.searchResultsTableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: self.searchResultsTableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: self.searchResultsTableView, attribute: .top, relatedBy: .equal, toItem: self.searcBar, attribute: .bottom, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: self.searchResultsTableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottomMargin, multiplier: 1, constant: 0)
        
        self.searchResultsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([leading, trailing, top, bottom])
        
        self.searchResultsTableView.delegate = self
        self.searchResultsTableView.dataSource = self
    }
    

}

//MARK: UISearchBarDelegate
extension SearchImageViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        self.hideKeyboard()
        
        let hideSpinner = self.createSpinner()
        self.viewModel.search(inputedText: text) { [weak self] error in
            guard let `self` = self else { return }
            hideSpinner()
            
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert(title: error.title, message: error.localizedDescription)
                } else {
                    self.searchResultsTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                }
            }
        }
    }
}

//MARK: UITableViewDelegate
extension SearchImageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
}

//MARK: UITableViewDataSource
extension SearchImageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.countOfResults()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = self.viewModel.getSearchResult(indexPath.row)
        let cell = SearchResultTableViewCell()
        cell.searchResult = searchResult
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchResultTableViewCell.height
    }
}
