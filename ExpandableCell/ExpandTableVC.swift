//
//  ExpandTableVC.swift
//  ExpandableCell
//
//  Created by Nick on 2018/12/1.
//  Copyright © 2018 kcin.nil.app. All rights reserved.
//

import UIKit

final class ExpandTableVC: UIViewController {
    
    private var models: [DataCollection]
    private let tableView: UITableView = UITableView()
    
    init(models: [DataCollection]) {
        self.models = models
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.mLaySafe(pin: .init(top: 0, left: 0, bottom: 0, right: 0))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 50
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func modelAt(indexPath: IndexPath) -> DataCollection? {
        return models[indexPath.section].getData(with: indexPath.row) as? DataCollection
    }
    
}

extension ExpandTableVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].itemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            fatalError("can't get reusable cell")
        }

        if let model = modelAt(indexPath: indexPath) {
            if model.subDatas.isEmpty {
                cell.textLabel?.text = "  " + model.string
            } else {
                cell.textLabel?.text = (model.isExpand ? "-  " : "+  ")  + model.string
            }
        } else {
            cell.textLabel?.text = "\(indexPath.section) : \(indexPath.row)"
        }
        if indexPath.section % 2 == 0 {
            cell.contentView.backgroundColor = .green
            cell.textLabel?.textColor = .black
        } else {
            cell.contentView.backgroundColor = .blue
            cell.textLabel?.textColor = .white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard var model = modelAt(indexPath: indexPath) else {
            fatalError("wtf, if nothing, what is you tap?")
        }
        tableView.deselectRow(at: indexPath, animated: true)
        model.expand(with: tableView, at: indexPath)
    }
}
