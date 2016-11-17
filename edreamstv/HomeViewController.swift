//
//  HomeViewController.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, ImageBackgroundView {
    
    var tableViewManager: TableViewManager?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableViewManager = TableViewManager(tableView: tableView, delegate: self)
            tableViewManager?.items = TravelItem.sampleItems
        }
    }
    
    @IBOutlet weak var imageBackgroundView: UIImageView! {
        didSet {
            let layer = CALayer()
            layer.frame = imageBackgroundView.bounds
            layer.backgroundColor = UIColor.black.cgColor
            layer.opacity = 0.3
            imageBackgroundView.layer.addSublayer(layer)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addPlayPauseTap()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "eDreams_logo_main")))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showSearch(_ sender: AnyObject) {
        present(packagedSearchController(), animated: true, completion: nil)
    }

    //MARK: Private methods
    private func packagedSearchController() -> UIViewController {
        let searchContainer = UISearchContainerViewController(searchController: SearchViewController())
        let searchNavigationController = UINavigationController(rootViewController: searchContainer)
        return searchNavigationController
    }
    
    private func addPlayPauseTap() {
        let playPauseTap = UITapGestureRecognizer(target: self, action: #selector(self.showSearch(_:)))
        playPauseTap.allowedPressTypes = [ NSNumber(value: UIPressType.playPause.rawValue) ]
        view.addGestureRecognizer(playPauseTap)
    }
}

extension HomeViewController: TableViewManagerDelegate {}
