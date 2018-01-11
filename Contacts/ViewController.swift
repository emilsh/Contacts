//
//  ViewController.swift
//  Contacts
//
//  Created by Emil Shafigin on 1/11/18.
//  Copyright © 2018 emksh. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let cellId = "cellId"
    var showIndexPaths = false
    
    var twoDimensionalArray = [
        ExpandableNames(isExpand: true, names: ["Emil", "Alina", "Adele"]),
        ExpandableNames(isExpand: true, names: ["Mars", "Kate", "Raul", "Nastya"]),
        ExpandableNames(isExpand: true, names: ["Bob", "Sergey", "Tanya"])
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        navigationItem.title = "Contacts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionalArray[section].isExpand {
            return 0
        }
        
        return twoDimensionalArray[section].names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let name = twoDimensionalArray[indexPath.section].names[indexPath.row]
        
        cell.textLabel?.text =
            showIndexPaths ? "\(name)\tSection: \(indexPath.section) Row: \(indexPath.row)" : name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton()
        button.backgroundColor = UIColor.yellow
        button.setTitle("Open", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        return button
    }
    
    //MARK: - Methods
    
    @objc private func handleExpandClose(button: UIButton) {

        var indexPaths = [IndexPath]()
        let section = button.tag
        
        for row in twoDimensionalArray[section].names.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpand = twoDimensionalArray[section].isExpand
        twoDimensionalArray[section].isExpand = !isExpand
        
        if isExpand {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    @objc private func handleShowIndexPath() {
        showIndexPaths = !showIndexPaths
        
        var indexPaths = [IndexPath]()
        
        for section in twoDimensionalArray.indices {
            
            for row in twoDimensionalArray[section].names.indices {
                let indexPath = IndexPath(row: row, section: section)
                indexPaths.append(indexPath)
            }
        }
        let rowAnimation = showIndexPaths ? UITableViewRowAnimation.right : .left
        tableView.reloadRows(at: indexPaths, with: rowAnimation)
        
    }
}

