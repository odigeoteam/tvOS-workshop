//
//  DetailTextViewController.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit

class DetailTextViewController: UIViewController {

    @IBOutlet weak var detailTextDescription: UILabel!
    @IBOutlet weak var detailTextTitle: UILabel!
    @IBOutlet weak var detailImageBackground: UIImageView!
    
    var item: TravelItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let item = item else { return }
        detailTextTitle.text = item.title
        detailTextDescription.text = item.beautifulDescription
        detailImageBackground.image = UIImage(named: item.backgroundImageName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DetailTextViewController: StoryboardLoadable {}
