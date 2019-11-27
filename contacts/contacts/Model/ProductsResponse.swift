//
//  ProductsResponse.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import Foundation

struct ProductsResponse: Codable {
    let count: Int
    let products: [String: Product]
    
    var productsInfo: [ProductInfo] {
        return products.map({(key, value) -> ProductInfo in
            return ProductInfo(id: key, product: value)
        }).sorted(by: { $0.product.popularityValue > $1.product.popularityValue })
    }
}

struct Product: Codable {
    let subcategory: String
    let title, price, popularity: String
    
    var popularityValue: Int {
        return Int(popularity) ?? 0
    }
}

struct ProductInfo: Codable {
    let id: String
    let product: Product
}
