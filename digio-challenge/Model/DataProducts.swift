//
//  DataProducts.swift
//  digio-challenge
//
//  Created by Renato Mateus on 08/11/21.
//

import Foundation

struct DataProducts: Codable {
    let spotlight: [Product]
}

struct Product: Codable {
    let name: String
    let bannerURL: String
    let description: String
}
