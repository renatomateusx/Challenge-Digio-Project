//
//  DataProducts.swift
//  digio-challenge
//
//  Created by Renato Mateus on 08/11/21.
//

import Foundation

enum Sections {
    case header
    case spotlight
    case products
    case cash
}

struct DataProducts: Codable {
    let spotlight: [SpotLight]
    let products: [Product]
    let cash: Cash
}

typealias SpotLights = [SpotLight]

struct SpotLight: Codable {
    let name: String
    let bannerURL: String
    let description: String
}

typealias Products = [Product]

struct Product: Codable {
    let name: String
    let imageURL: String
    let description: String
}

struct Cash: Codable {
    let title: String
    let bannerURL: String
    let description: String
}

// We can try to use coding keys after ready to minimize structs length turning it in just one struct getting let case for each type of spotlight, products, or cash
