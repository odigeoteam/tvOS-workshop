//
//  TravelItemDataSource.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit

protocol TableViewManagerDelegate {
    func didSelect(_ travelItem: TravelItem)
    func didUpdateFocusIn(_ travelItem: TravelItem)
}

class TableViewManager: NSObject {
    
    var tableView: UITableView?
    var delegate: TableViewManagerDelegate?
    
    var items: [TravelItem]? {
        didSet {
            reloadSections()
            tableView?.reloadData()
        }
    }
    fileprivate var sections: [TravelItem.Group] = []
    
    convenience init(tableView: UITableView, delegate: TableViewManagerDelegate?) {
        self.init()
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(CollectionViewContainerCell.nib, forCellReuseIdentifier: CollectionViewContainerCell.reuseIdentifier)
        self.tableView?.register(TableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: TableViewHeaderView.reuseIdentifier)
        self.tableView?.allowsSelection = false
        self.tableView?.separatorInset = UIEdgeInsets(top: 0, left: 90, bottom: 0, right: 90)
        self.tableView?.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 60, right: 0)
        
        self.delegate = delegate
    }
    
    fileprivate func reloadSections() {
        if let items = items {
            sections = items.reduce([], { (result, item) -> [TravelItem.Group] in
                if result.contains(item.group) { return result }
                else { return result + [item.group] } })
        } else {
            sections = []
        }
    }
}

extension TableViewManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: CollectionViewContainerCell.reuseIdentifier, for: indexPath) as! CollectionViewContainerCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
}

extension TableViewManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CollectionViewContainerCell.height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CollectionViewContainerCell else { fatalError("Expected to display CollectionViewContainerCell.") }
        cell.delegate = self
        
        if let groupItems = items?.filter( { return $0.group == sections[indexPath.section] }) {
            cell.items = groupItems
        } else {
            cell.items = []
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TableViewHeaderView.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewHeaderView.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? TableViewHeaderView else { fatalError("Expected to display TableViewHeaderView.") }
        header.textLabel?.text = sections[section].headerDescription()
    }
}

extension TableViewManager: TableViewManagerDelegate {
    func didSelect(_ travelItem: TravelItem) {
        delegate?.didSelect(travelItem)
    }
    
    func didUpdateFocusIn(_ travelItem: TravelItem) {
        delegate?.didUpdateFocusIn(travelItem)
    }
}
