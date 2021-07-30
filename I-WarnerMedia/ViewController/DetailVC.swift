//
//  DetailVC.swift
//  I-WarnerMedia
//
//  Created by Kobi Cook on 7/29/21.
//

import UIKit


protocol DetailDelegate: AnyObject {
    func favoriteToggled()
}

class DetailVC: UIViewController {

    private let detailAlbumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let detailMainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }()
    
    private let detailSubLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    private let detailSubLabel2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.textColor = .red
        return label
    }()
    
    private let detailButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.layer.borderWidth = 2
        button.tintColor = .systemRed
        button.layer.borderColor = button.tintColor.cgColor
        button.layer.masksToBounds = false
        return button
    }()
    
    
    weak var delegate: DetailDelegate?
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadAlbumImage()
        setupDetail()
        setupDetailConstraints()
    }
    
    
    private func downloadAlbumImage() {
        guard let url = viewModel.currentProduct.imageUrl else {
            detailAlbumImage.image = UIImage(named: "default")
            return
        }
        
        cacheManager.downloadImage(from: url) { [weak self] dat in
            if let data = dat, let image = UIImage(data: data) {
                self?.detailAlbumImage.image = image
            }
        }
    }
    
    
    private func setupDetailConstraints() {
        

        let labelStackView = UIStackView(arrangedSubviews: [detailMainLabel, detailSubLabel, detailSubLabel2])
        labelStackView.distribution = .equalSpacing
        labelStackView.alignment = .center
        labelStackView.spacing = 6
        labelStackView.axis = .vertical
        
        view.addSubviews(detailAlbumImage, labelStackView, detailButton)
        
        detailAlbumImage.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 100, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 250))
        
        labelStackView.anchor(top: detailAlbumImage.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 15, bottom: 0, right: 15), size: .init(width: 0, height: 0))
        
        detailButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 20, right: 20), size: .init(width: 0, height: 40))
        
    }
    
    private func setupDetail() {
        
        view.backgroundColor = .white
        
        detailMainLabel.text = viewModel.currentProduct.title
        detailSubLabel.text = viewModel.currentProduct.author
        detailSubLabel2.text = "Favorited"
        detailButton.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)
        
        setButtonText()
        detailSubLabel2.isHidden = !viewModel.currentProduct.isFavorite
    }
    
    
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        viewModel.currentProduct.isFavorite.toggle()
        setButtonText()
    }
    
    private func setButtonText() {
        switch viewModel.currentProduct.isFavorite {
        case true:
            detailButton.setTitle("UnFavorite", for: .normal)
            detailSubLabel2.isHidden = false
        case false:
            detailButton.setTitle("Favorite", for: .normal)
            detailSubLabel2.isHidden = true
        }
        delegate?.favoriteToggled()
    }

}
