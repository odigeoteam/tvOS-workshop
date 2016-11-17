//
//  TravelItemCollectionViewCell.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit

class TravelItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    var item: TravelItem? {
        didSet {
            if let imageName = item?.imageName {
                imageView.image = UIImage(named: imageName)
            } else {
                imageView.image = nil
            }
            title.text = item?.title
            subTitle.text = item?.subTitle
        }
    }
    
    lazy fileprivate var horizontalAxisMotionEffect: UIMotionEffect = {
        let horizontalAxisMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontalAxisMotionEffect.minimumRelativeValue = -12.0
        horizontalAxisMotionEffect.maximumRelativeValue = 12.0

        return horizontalAxisMotionEffect
    }()
    
    
    lazy fileprivate var verticalAxisMotionEffect: UIMotionEffect = {
        let verticalAxisMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        verticalAxisMotionEffect.minimumRelativeValue = -12.0
        verticalAxisMotionEffect.maximumRelativeValue = 12.0
        return verticalAxisMotionEffect
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.adjustsImageWhenAncestorFocused = true
        imageView.clipsToBounds = false
    }
}

extension TravelItemCollectionViewCell {
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        coordinator.addCoordinatedAnimations({
            
            if self.isFocused {
                let scaleX = self.imageView.focusedFrameGuide.layoutFrame.size.width / self.imageView.frame.size.width
                let scaleY = self.imageView.focusedFrameGuide.layoutFrame.size.height / self.imageView.frame.size.height
                let translationY = abs(self.imageView.focusedFrameGuide.layoutFrame.origin.y)
                self.bottomView.transform = CGAffineTransform(scaleX: scaleX, y: scaleY).concatenating(CGAffineTransform(translationX: 0, y: translationY))
                self.bottomView.addMotionEffect(self.horizontalAxisMotionEffect)
                self.bottomView.addMotionEffect(self.verticalAxisMotionEffect)
            }
            else {
                self.bottomView.transform = CGAffineTransform.identity
                self.bottomView.removeMotionEffect(self.horizontalAxisMotionEffect)
                self.bottomView.removeMotionEffect(self.verticalAxisMotionEffect)
            }
        }, completion: nil)
    }
}

extension TravelItemCollectionViewCell: NibLoadableView {}
