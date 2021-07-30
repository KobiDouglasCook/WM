//
//  Product.swift
//  I-WarnerMedia
//
//  Created by Kobi Cook on 7/29/21.
//

import Foundation


class Product: Codable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case imageUrl
        case author
    }
    
    let title: String
    let imageUrl: String?
    let author: String?
    
    var isFavorite: Bool = false
    
    
    init(title: String, author: String) {
        self.title = title
        self.author = author
        self.imageUrl = ""
    }
}
