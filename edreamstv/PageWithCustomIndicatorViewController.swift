//
//  PageWithCustomIndicatorViewController.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit

class PageWithCustomIndicatorViewController: CustomPageViewController {

    var items: [ViewControllable & PageControllable]? {
        didSet {
            if let items = items {
                pages = items.map { $0.viewController }
            }
        }
    }
    var pageIndicatorView: PageIndicatorView!
    var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLogoImageView()
        addPageIndicatorView()
        //TODO: Step 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showDetailText(_ sender: AnyObject) {
        //TODO: Step 4
    }
    
    //MARK: Private methods
    private func addPageIndicatorView() {
        
        if let items = items, pageIndicatorView == nil {
            pageIndicatorView = PageIndicatorView(items: items)
            pageIndicatorView.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(pageIndicatorView)
            view.addConstraint(NSLayoutConstraint(item: pageIndicatorView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 100))
            view.addConstraint(NSLayoutConstraint(item: pageIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
        }
    }
    
    private func addLogoImageView() {
        if logoImageView == nil {
            logoImageView = UIImageView(image: UIImage(named:"eDreams_logo_main"))
            logoImageView.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(logoImageView)
            view.addConstraint(NSLayoutConstraint(item: logoImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 60))
            view.addConstraint(NSLayoutConstraint(item: logoImageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        }
    }
    
    private func detailTextViewController() -> UIViewController {
        let detailTextViewController = DetailTextViewController.viewController() as! DetailTextViewController
        detailTextViewController.item = item
        return detailTextViewController
    }
}

//MARK: Overriden UIPageViewControllerDelegate
extension PageWithCustomIndicatorViewController {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        pageIndicatorView.selectedIndex = currentIndex
    }
}

extension PageWithCustomIndicatorViewController: StoryboardLoadable {}
