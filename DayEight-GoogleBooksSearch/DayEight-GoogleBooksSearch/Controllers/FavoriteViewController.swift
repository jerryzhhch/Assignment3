//
//  FavoriteViewController.swift
//  DayEight-GoogleBooksSearch
//
//  Created by Jerry Zhou on 5/10/19.
//  Copyright © 2019 Jerry Zhou. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteView: UITableView!
    
    var books = [Book]() {
        didSet{
            favoriteView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DispatchQueue.main.async {
            self.books = coreDataService.getBook()
        }
    }
    
    // helping functions
    func setupView() {
        favoriteView.rowHeight = 150
        favoriteView.tableFooterView = UIView(frame: .zero)
        
        DispatchQueue.main.async {
            self.books = coreDataService.getBook()
        }
    }
}
