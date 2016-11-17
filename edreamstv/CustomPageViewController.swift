//
//  CustomPageViewController.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit

class CustomPageViewController : UIPageViewController {
    var item: TravelItem? {
        didSet {
            if let item = item {
                pages = item.detailItems().map { $0.viewController }
            }
        }
    }
    
    var pages: [UIViewController]? {
        didSet {
            if let firstItem = pages?.first {
                setViewControllers([firstItem], direction: .forward, animated: false, completion: nil)
            }
        }
    }
    
    var currentIndex: Int {
        guard let pages = pages, let firstViewController = viewControllers?.first, let index = pages.index(of: firstViewController) else { return 0 }
        return index
    }
    
    var totalPages: Int {
        return pages?.count ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
    }
}

extension CustomPageViewController : UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return totalPages
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let pages = pages, let index = pages.index(of: viewController) else { return nil }
        return index < totalPages - 1 ? pages[index + 1] : nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let pages = pages, let index = pages.index(of: viewController) else { return nil }
            return index > 0 ? pages[index - 1] : nil
    }
}

extension CustomPageViewController: UIPageViewControllerDelegate {}
