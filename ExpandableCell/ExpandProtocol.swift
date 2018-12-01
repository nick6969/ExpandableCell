//
//  ExpandProtocol.swift
//  ExpandableCell
//
//  Created by Nick on 2018/12/1.
//  Copyright © 2018 kcin.nil.app. All rights reserved.
//

import UIKit

protocol ExpandProtocol {
    var isExpand: Bool { get set }
    var subDatas: [ExpandProtocol] { get set }
    func itemCount() -> Int
    func getData(with index: Int) -> ExpandProtocol?
    mutating func expand(with tableView: UITableView, at indexPath: IndexPath)
    mutating func expand(with collectionView: UICollectionView, at indexPath: IndexPath)
}

extension ExpandProtocol {
    func itemCount() -> Int {
        return isExpand ? subDatas.reduce(1) { $0 + $1.itemCount() } : 1
    }
    
    func getData(with index: Int) -> ExpandProtocol? {
        if index == 0 { return self }
        var newIndex = index
        for sub in subDatas {
            let subCount = sub.itemCount()
            if  subCount >= newIndex {
                return sub.getData(with: newIndex - 1)
            } else {
                newIndex -= subCount
            }
        }
        return nil
    }
    
    mutating func expand(with tableView: UITableView, at indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard !subDatas.isEmpty else { return }
        
        let (isInsert, indexPaths) = getChangeIndexPaths(with: indexPath)
        tableView.beginUpdates()
        if isInsert {
            tableView.insertRows(at: indexPaths, with: .fade)
        } else {
            tableView.deleteRows(at: indexPaths, with: .fade)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    mutating func expand(with collectionView: UICollectionView, at indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard !subDatas.isEmpty else { return }
        
        let (isInsert, indexPaths) = getChangeIndexPaths(with: indexPath)
        collectionView.performBatchUpdates({
            if isInsert {
                collectionView.insertItems(at: indexPaths)
            } else {
                collectionView.deleteItems(at: indexPaths)
            }
            collectionView.reloadItems(at: [indexPath])
        }, completion: nil)
    }

    private mutating func getChangeIndexPaths(with indexPath: IndexPath) -> (Bool, [IndexPath]) {
        let oldCount = itemCount()
        self.isExpand.toggle()
        let newCount = itemCount()
        if isExpand {
            let offset = newCount - oldCount
            let indexs = (1...offset).map { IndexPath(item: indexPath.row + $0, section: indexPath.section)}
            return (true, indexs)
        } else {
            let offset = oldCount - newCount
            let indexs = (1...offset).map { IndexPath(item: indexPath.row + $0, section: indexPath.section)}
            return (false, indexs)
        }
    }

}
