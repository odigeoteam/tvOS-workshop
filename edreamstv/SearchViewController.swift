//
//  SearchViewController.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit

class SearchViewController: UISearchController, ImageBackgroundView {

    var imageBackgroundView: UIImageView! {
        didSet {
            let layer = CALayer()
            layer.frame = imageBackgroundView.bounds
            layer.backgroundColor = UIColor.black.cgColor
            layer.opacity = 0.3
            imageBackgroundView.layer.addSublayer(layer)
        }
    }
    
    init() {
        let searchResultsController = SearchResultsViewController.viewController() as! SearchResultsViewController
        super.init(searchResultsController: searchResultsController)
        searchResultsUpdater = searchResultsController
        searchResultsController.delegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addImageBackgroundView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private methods
    private func addImageBackgroundView() {
        if imageBackgroundView == nil {
            imageBackgroundView = UIImageView(frame: view.frame)
            imageBackgroundView.alpha = 0.0
            imageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(imageBackgroundView)
            view.sendSubview(toBack: imageBackgroundView)
            
            let views = ["imageBackgroundView": imageBackgroundView]
            var allConstraints = [NSLayoutConstraint]()
            allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageBackgroundView]|", options: [], metrics: nil, views: views)
            allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageBackgroundView]|", options: [], metrics: nil, views: views)
            NSLayoutConstraint.activate(allConstraints)
        }
    }
}

extension SearchViewController {
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        
        coordinator.addCoordinatedAnimations({
            if let _ = context.nextFocusedView as? UICollectionViewCell{
                self.imageBackgroundView.alpha = 1.0
            } else {
                self.imageBackgroundView.alpha = 0.0
            }
        }, completion: nil)
    }
}

extension SearchViewController {
    /*
     Cambiar entre styles cmd+shift+D
     
     Tambien podriamos jugar con el Appearance Proxy
     
     UIButton.appearance().setTitleColor(.red, for: [])
     let light = UITraitCollection(userInterfaceStyle: .light)
     let dark = UITraitCollection(userInterfaceStyle: .dark)
     UIButton.appearance(for: light).setTitleColor(.red, for:[])
     UIButton.appearance(for: dark).setTitleColor(.blue, for:[])
     */
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // Is userInterfaceStyle available?
        guard(traitCollection.responds(to: #selector(getter: UITraitCollection.userInterfaceStyle)))
            else { return }
        // Did the userInterfaceStyle change?
        guard(traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle)
            else { return }
        if traitCollection.userInterfaceStyle == .dark {
            // Handle .dark
            view.backgroundColor = UIColor(red: 0, green: 51/255, blue: 203/255, alpha: 0.3)
        }
        else {
            // Handle .light
            view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        }
    }
}

extension SearchViewController: TableViewManagerDelegate {}
