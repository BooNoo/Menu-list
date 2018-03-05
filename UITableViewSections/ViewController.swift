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
    
    
    let cartLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.text = "5"
        return label
    }()
    
    let cartButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cartImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "cart")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var twoDementionsArray = [
        MenuCategory(isExpanded: false, name: "Бургеры&Панини", products: [Product(name: "Бургеры&Панини", price: 100), Product(name: "Завертон", price: 100),Product(name: "Завертон", price: 100),Product(name: "Завертон с очень большим названием", price: 100),Product(name: "Завертон", price: 100),Product(name: "Завертон", price: 100),Product(name: "Завертон", price: 100),Product(name: "Завертон", price: 100)]),
        MenuCategory(isExpanded: false, name: "Завертоны", products: [Product(name: "Завертоны", price: 100),Product(name: "Завертон", price: 100),Product(name: "Завертон", price: 100)]),
        MenuCategory(isExpanded: false, name: "Салаты&Горячее", products: [Product(name: "Салаты&Горячее", price: 100),Product(name: "Завертон", price: 100),Product(name: "Завертон", price: 100)]),
        MenuCategory(isExpanded: false, name: "Десерты", products: [Product(name: "Десерты", price: 100),Product(name: "Завертон", price: 100),Product(name: "Завертон", price: 100)]),
        MenuCategory(isExpanded: false, name: "Кофе&Цай", products: [Product(name: "Кофе&Чай", price: 100),Product(name: "Завертон", price: 100)]),
        MenuCategory(isExpanded: false, name: "Согревающие напитки",products: [Product(name: "Согревающие напитки", price: 100)]),
        MenuCategory(isExpanded: false, name: "Фирменные коктейли",products: [Product(name: "Фирменные коктейли", price: 100)]),
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
        setButtonView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartButton)
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(ProductCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = getCategoryImage(category: twoDementionsArray[section].name.uppercased())
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 26, weight: .light)
        label.text = twoDementionsArray[section].name.uppercased()
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
        return 90
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
    
    func setButtonView() {
        
        cartButton.addSubview(cartLabel)
        cartButton.addSubview(cartImage)

        NSLayoutConstraint.activate([
            cartButton.heightAnchor.constraint(equalToConstant: 50),
            cartButton.widthAnchor.constraint(equalToConstant: 30),
            
//            cartImage.heightAnchor.constraint(equalToConstant: 50),
//            cartImage.widthAnchor.constraint(equalToConstant: 50),
            
            cartImage.leftAnchor.constraint(equalTo: cartButton.leftAnchor),
//            cartImage.rightAnchor.constraint(equalTo: cartButton.rightAnchor),
            cartImage.centerYAnchor.constraint(equalTo: cartButton.centerYAnchor),
//            cartImage.bottomAnchor.constraint(equalTo: cartButton.bottomAnchor),
            
//            cartLabel.heightAnchor.constraint(equalToConstant: 50),
            cartLabel.widthAnchor.constraint(equalToConstant: 25),
            
//            cartLabel.rightAnchor.constraint(equalTo: cartButton.rightAnchor),
            cartLabel.leftAnchor.constraint(equalTo: cartImage.rightAnchor, constant: 8),
//            cartLabel.topAnchor.constraint(equalTo: cartButton.topAnchor),
            cartLabel.bottomAnchor.constraint(equalTo: cartImage.bottomAnchor),
            
            
            ])
    }
    
    func getCategoryImage(category:String) -> UIImage? {
        switch category {
        case "БУРГЕРЫ&ПАНИНИ":
            return UIImage(named: "burgers")
        case "ЗАВЕРТОНЫ":
            return UIImage(named: "rolls")
        case "САЛАТЫ&ГОРЯЧЕЕ":
            return UIImage(named: "salat")
        case "ДЕСЕРТЫ":
            return UIImage(named: "desert")!
        case "КОФЕ&ЦАЙ":
            return UIImage(named: "coffee")!
        case "ICE-MENU":
            return UIImage(named: "ice-menu")!
        case "ФРУКТОВЫЕ ШЕЙКИ":
            return UIImage(named: "fructshake")!
        case "ФИРМЕННЫЕ КОКТЕЙЛИ":
            return UIImage(named: "cocktails")!
        case "ПИЦЦА":
            return UIImage(named: "pizza")!
        case "СОГРЕВАЮЩИЕ НАПИТКИ":
            return UIImage(named: "hotdrinks")!
        case "СПЕЦПРЕДЛОЖЕНИЯ":
            return UIImage(named: "special")!
        default:
            return UIImage(named: "special")!
        }
    }
    
}

fileprivate extension Selector {
    static let expandClose = #selector(ViewController.handleExpandClose)
}
