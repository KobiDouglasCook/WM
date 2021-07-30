//
//  ProductTableCell.swift
//  I-WarnerMedia
//
//  Created by Kobi Cook on 7/29/21.
//

import UIKit

class ProductTableCell: UITableViewCell {
    
    private let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let productMainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .darkGray
        return label
    }()
    
    private let productSubLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 11)
        label.textAlignment = .left
        label.textColor = .lightGray
        return label
    }()
    
    private let favoriteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 11)
        label.textAlignment = .right
        label.textColor = .red
        label.text = "Favorite"
        return label
    }()

    var product: Product? {
        didSet {
            guard let product = product else { return }
            productMainLabel.text = product.title
            productSubLabel.text = product.author
            
            favoriteLabel.isHidden = !product.isFavorite
            
            guard let url = product.imageUrl else {
                productImage.image = UIImage(named: "default")
                return
            }
            
            cacheManager.downloadImage(from: url) { [weak self] dat in
                if let data = dat, let image = UIImage(data: data) {
                    self?.productImage.image = image
                }
            }
        }
    }
    
    
    static let identifier = String(describing: ProductTableCell.self)

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let labelStackView = UIStackView(arrangedSubviews: [productMainLabel, productSubLabel])
        labelStackView.distribution = .equalSpacing
        labelStackView.axis = .vertical
        labelStackView.spacing = 5
        
        addSubviews(productImage, labelStackView, favoriteLabel)
        
        productImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 5, left: 5, bottom: 5, right: 0), size: .init(width: 80, height: 0))
        
        labelStackView.anchor(top: topAnchor, leading: productImage.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 0))
        
        favoriteLabel.anchor(top: topAnchor, leading: nil, bottom: labelStackView.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 10))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    


}
