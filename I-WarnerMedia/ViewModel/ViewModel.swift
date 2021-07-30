//
//  ViewModel.swift
//  I-WarnerMedia
//
//  Created by Kobi Cook on 7/29/21.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func update()
}

class ViewModel {
    
    var products = [Product]() {
        didSet {
            delegate?.update()
        }
    }
    
    var currentProduct: Product!
    
    weak var delegate: ViewModelDelegate?
    
}

extension ViewModel {
    
    func get() {
        ServiceManager.shared.get { [unowned self] result in
            switch result {
            case .success(let prods):
                self.products = prods
                print("received products from service: \(prods.count)")
            case .failure(let error):
                print("Error getting products: \(error.localizedDescription)")
            }
        }
    }
    
    func setCurrentProduct(for index: IndexPath) {
        self.currentProduct = products[index.row]
    }
    
    func getProductCount() -> Int {
        return products.count
    }
    
    func getProduct(for index: IndexPath) -> Product {
        return products[index.row]
    }
    
}
