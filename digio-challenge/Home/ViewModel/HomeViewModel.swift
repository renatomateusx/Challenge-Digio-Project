//
//  HomeViewModel.swift
//  digio-challenge
//
//  Created by Renato Mateus on 08/11/21.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func onSuccessFetchingProducts(products: DataProducts)
    func onFailureFetchingProducts(error: Error)
}

class HomeViewModel {
    
    // MARK: - Private Properties
    let productsService: ProductsServiceProtocol
    var delegate: HomeViewModelDelegate?
    let sections: [Sections] = [.header, .spotlight, .cash, .products]
    // MARK: - Inits
    
    init(with service: ProductsServiceProtocol) {
        self.productsService = service
    }
    
    func fetchProducts() {
        productsService.fetchProducts { result in
            switch result {
            
            case .success(let products):
                self.delegate?.onSuccessFetchingProducts(products: products)
            case .failure(let error):
                self.delegate?.onFailureFetchingProducts(error: error)
            }
        }
    }
}
