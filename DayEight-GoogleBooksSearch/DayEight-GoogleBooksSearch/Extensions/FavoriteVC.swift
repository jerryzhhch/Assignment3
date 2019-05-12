//
//  FavoriteVC.swift
//  DayEight-GoogleBooksSearch
//
//  Created by Jerry Zhou on 5/11/19.
//  Copyright © 2019 Jerry Zhou. All rights reserved.
//

import Foundation
import UIKit

extension FavoriteViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let book = books[indexPath.row]
            books.remove(at: indexPath.row)
            coreDataService.deleteBook(book)
        default:
            break
        }
    }
}

extension FavoriteViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteViewCell", for: indexPath) as! FavoriteViewCell
        
        let book = books[indexPath.row]
        cell.configiure(book: book)
        
        return cell
    }
    
}
