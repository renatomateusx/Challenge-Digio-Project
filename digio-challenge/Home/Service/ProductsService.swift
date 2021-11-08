//
//  ProductsService.swift
//  digio-challenge
//
//  Created by Renato Mateus on 08/11/21.
//

import Foundation
protocol ProductsServiceProtocol: AnyObject {
    func fetchProducts(completion: @escaping(Result<DataProducts, Error>) -> Void)
}

class ProductsService {
    private var service: NetworkService
    
    init(service: NetworkService = NetworkService()) {
        self.service = service
    }
}

extension ProductsService: ProductsServiceProtocol {
    func fetchProducts(completion: @escaping(Result<DataProducts, Error>) -> Void) {
        let url = URL(string: Constants.productsURL)!
        _ = service.request(for: url, completion: completion)
    }
}
