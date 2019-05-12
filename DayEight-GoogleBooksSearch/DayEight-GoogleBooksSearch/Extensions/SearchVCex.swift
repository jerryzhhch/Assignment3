//
//  SearchVCex.swift
//  DayEight-GoogleBooksSearch
//
//  Created by Jerry Zhou on 5/10/19.
//  Copyright © 2019 Jerry Zhou. All rights reserved.
//

import Foundation
import UIKit

// extension for SearchViewController

extension SearchViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        
        let book = books[indexPath.row]
        detailVC.book = book
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SearchViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        let book = books[indexPath.row]
        cell.configure(book: book)
        return cell
    }
}

extension SearchViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // get words to search
        guard let text = searchBar.text else{
            showAlert("Empty text")
            print()
            return
        }
        // call search function
        search(text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
}

extension SearchViewController {
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okay)
        present(alert, animated: true, completion: nil)
    }
}
