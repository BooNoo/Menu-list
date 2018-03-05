//
//  ProductCell.swift
//  UITableViewSections
//
//  Created by Vladimir Mikhaylov on 04.03.2018.
//  Copyright © 2018 Vladimir Mikhaylov. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    var product: Product? {
        didSet {
            guard let unwrappedProduct = product else { return }
            name.text = unwrappedProduct.name
            price.text = String(unwrappedProduct.price) + " ₽"
        }
    }
    
    let name: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    let price: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textColor = UIColor(red: 205/255, green: 38/255, blue: 38/255, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    let cellImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "burger")
        return imageView
    }()
    
    let buyButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let buyButtonImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "buy")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        buyButton.addTarget(self, action: #selector(buyProduct), for: .touchUpInside)
        
        let productInfo = UIStackView(arrangedSubviews: [name, price])
        productInfo.translatesAutoresizingMaskIntoConstraints = false
        productInfo.axis = .vertical
        productInfo.distribution = .fillEqually
        
        addSubview(cellImageView)
        addSubview(productInfo)
        addSubview(buyButton)
        buyButton.addSubview(buyButtonImageView)
        
        NSLayoutConstraint.activate([
            
            cellImageView.widthAnchor.constraint(equalToConstant: 75),
            cellImageView.heightAnchor.constraint(equalToConstant: 75),
            cellImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            buyButton.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            buyButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            buyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            buyButton.widthAnchor.constraint(equalToConstant: 100),
            
            buyButtonImageView.centerXAnchor.constraint(equalTo: buyButton.centerXAnchor),
            buyButtonImageView.centerYAnchor.constraint(equalTo: buyButton.centerYAnchor),
            
            productInfo.centerYAnchor.constraint(equalTo: centerYAnchor),
            productInfo.heightAnchor.constraint(greaterThanOrEqualTo: cellImageView.heightAnchor, multiplier: 0),
            productInfo.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            productInfo.leftAnchor.constraint(equalTo: cellImageView.rightAnchor, constant: 0),
            productInfo.rightAnchor.constraint(equalTo: buyButton.leftAnchor, constant: 0),

            ])
    }
    
    @objc func buyProduct() {
        print("add to cart")
    }
}
