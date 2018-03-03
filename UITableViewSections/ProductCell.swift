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
            price.text = String(unwrappedProduct.price)
        }
    }
    
    let name: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    let price: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    
    let cellImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "burger")
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
        
        let productInfo = UIStackView(arrangedSubviews: [name, price])
        productInfo.translatesAutoresizingMaskIntoConstraints = false
        productInfo.axis = .vertical
        productInfo.distribution = .fillEqually
        
        addSubview(cellImageView)
        addSubview(productInfo)
        
        NSLayoutConstraint.activate([
            
            cellImageView.widthAnchor.constraint(equalToConstant: 100),
            cellImageView.heightAnchor.constraint(equalToConstant: 100),
            
            cellImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            productInfo.centerYAnchor.constraint(equalTo: centerYAnchor),
            productInfo.heightAnchor.constraint(greaterThanOrEqualTo: cellImageView.heightAnchor, multiplier: 0),
            productInfo.leftAnchor.constraint(equalTo: cellImageView.rightAnchor, constant: 16),
            productInfo.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
//            price.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 16)
            
            ])
        
    }
}
