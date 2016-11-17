//
//  SearchResultsViewController.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    var tableViewManager: TableViewManager?
    var delegate: TableViewManagerDelegate? {
        didSet {
            tableViewManager?.delegate = delegate
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableViewManager = TableViewManager(tableView: tableView, delegate: delegate)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SearchResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            tableViewManager?.items = TravelItem.sampleItems.filter {
                $0.title.localizedCaseInsensitiveContains(text)
            }
        } else {
            tableViewManager?.items = []
        }
    }
}

extension SearchResultsViewController: StoryboardLoadable {}

