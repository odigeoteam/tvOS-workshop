//
//  TravelTableViewCell.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit

class CollectionViewContainerCell: UITableViewCell {
    
    static let height: CGFloat = 336.0

    var items: [TravelItem] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var delegate: TableViewManagerDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(TravelItemCollectionViewCell.nib, forCellWithReuseIdentifier: TravelItemCollectionViewCell.reuseIdentifier)
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 90, bottom: 0, right: 90)
        }
    }
}

extension CollectionViewContainerCell: NibLoadableView {}

extension CollectionViewContainerCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        return collectionView.dequeueReusableCell(withReuseIdentifier: TravelItemCollectionViewCell.reuseIdentifier, for: indexPath)
    }
}

extension CollectionViewContainerCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? TravelItemCollectionViewCell else { return }
        cell.item = items[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(items[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        guard let indexPath = context.nextFocusedIndexPath else { return }
        delegate?.didUpdateFocusIn(items[indexPath.row])
    }
}
