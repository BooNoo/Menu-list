//
//  ViewController.swift
//  UITableViewSections
//
//  Created by Vladimir Mikhaylov on 20.11.2017.
//  Copyright © 2017 Vladimir Mikhaylov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let cellId = "cellId"
    var isExpanded = false
    var showIndexPath = false
    
    var product = Product(name: "Завертон", price: 100)
    
    var twoDementionsArray = [
        ExpandableNames(isExpanded: false, name: "Завертон", products: [Product(name: "Завертон", price: 100), Product(name: "Завертон", price: 100),Product(name: "Завертон", price: 100),Product(name: "Завертон с очень приочень большим названием, может даже больше чем надо", price: 100),Product(name: "Завертон", price: 100),Product(name: "Завертон", price: 100),Product(name: "Завертон", price: 100),Product(name: "Завертон", price: 100)]),
        ExpandableNames(isExpanded: false, name: "1", products: [Product(name: "Завертон", price: 100),Product(name: "Завертон", price: 100),Product(name: "Завертон", price: 100)]),
        ExpandableNames(isExpanded: false, name: "2", products: [Product(name: "Завертон", price: 100),Product(name: "Завертон", price: 100),Product(name: "Завертон", price: 100)]),
        ExpandableNames(isExpanded: false, name: "3", products: [Product(name: "Завертон", price: 100),Product(name: "Завертон", price: 100),Product(name: "Завертон", price: 100)]),
        ExpandableNames(isExpanded: false, name: "4", products: [Product(name: "Завертон", price: 100),Product(name: "Завертон", price: 100)]),
        ExpandableNames(isExpanded: false, name: "5",products: [Product(name: "Завертон", price: 100)]),
        ]
    
    @objc func handleShowIndexPath() {
        var indexPathToReload = [IndexPath]()
        for section in twoDementionsArray.indices {
            if twoDementionsArray[section].isExpanded {
                for row in twoDementionsArray[section].products.indices {
                    let indexPath = IndexPath(row: row, section: section)
                    indexPathToReload.append(indexPath)
                }
            }
        }
        showIndexPath = !showIndexPath
        let animationStyle = showIndexPath ? UITableViewRowAnimation.right : .left
        tableView.reloadRows(at: indexPathToReload, with: animationStyle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Меню"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(ProductCell.self, forCellReuseIdentifier: cellId)
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "food")
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 26, weight: .light)
        label.text = twoDementionsArray[section].name
        label.textAlignment = .center
        
        let button = UIButton(type: .system)
        button.setTitle(twoDementionsArray[section].name, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: .expandClose, for: .touchUpInside)
        button.tag = section
        
        imageView.addSubview(label)
        button.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: button.leftAnchor, constant: 8),
            imageView.rightAnchor.constraint(equalTo: button.rightAnchor, constant: -8),
            imageView.topAnchor.constraint(equalTo: button.topAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: 0),
            
            label.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 8),
            label.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -8),
            label.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8),
            ])
        
        return button
    }
    
    @objc func handleExpandClose(button: UIButton) {
        let section = button.tag
        var indexPaths = [IndexPath]()
        for row in twoDementionsArray[section].products.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = twoDementionsArray[section].isExpanded
        twoDementionsArray[section].isExpanded = !isExpanded
        
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDementionsArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDementionsArray[section].isExpanded {
            return 0
        }
        return twoDementionsArray[section].products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductCell
        cell.product = twoDementionsArray[indexPath.section].products[indexPath.row]
        return cell
    }
    
}

fileprivate extension Selector {
    static let expandClose = #selector(ViewController.handleExpandClose)
}















