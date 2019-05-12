//
//  SearchViewController.swift
//  DayEight-GoogleBooksSearch
//
//  Created by Jerry Zhou on 5/10/19.
//  Copyright © 2019 Jerry Zhou. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var books = [Book]() {
        didSet {
            tableView.reloadData()
        }
        willSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // helping functions
    func setupView() {
        
        // register cell
        tableView.register(UINib(nibName: "TableViewCell", bundle: .main), forCellReuseIdentifier: TableViewCell.identifier)
        
        // auto layout
        tableView.estimatedRowHeight = 80
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func search(_ query: String) {
        // add search query to URL string
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=" + query
        
        let escapedQuery = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        // convert to URL?, and unwrap (URL? -> URL)
        guard let url = URL(string: escapedQuery!) else {
            print("error")
            return
        }
        
        // DON'T forget to *resume*
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let myError = err {
                print("Error: \(myError.localizedDescription)")
            }
            
            // get Data
            if let myData = data {
//                print("Data: ", myData)
                
                // create a JSON object (there is a throw)
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: myData, options: []) as? [String:Any], let parseData = jsonObject["items"] as? [[String:Any]] else {
                        print("Bad JSON Format")
                        // clear table view, if no search result
                        DispatchQueue.main.async {
                            self.showAlert("Result NOT Found")
                            self.books.removeAll()
                        }
                        return
                    }
//                    print("JSON Data: ", parseData)
                    
                    var myBooks = [Book]()
                    for item in parseData {
                        
                        if let book = Book(json: item) {
                            myBooks.append(book)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.books = myBooks
                        print("Number of books found: \(self.books.count)")
                    }
                  
                } catch {
                    print("Couldn't Serialize Object: \(error.localizedDescription)")
                }
                
            }
        }.resume()
    }
}

