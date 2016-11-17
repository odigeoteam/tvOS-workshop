//
//  DetailImageViewController.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit

class DetailImageViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    var item: DetailCarouselImageItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let item = item else { return }
        
        detailImageView.loadImage(fromURL: item.imageURL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DetailImageViewController: StoryboardLoadable {}
