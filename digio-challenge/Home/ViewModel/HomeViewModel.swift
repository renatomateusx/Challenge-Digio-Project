//
//  HomeViewModel.swift
//  digio-challenge
//
//  Created by Renato Mateus on 08/11/21.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func onSuccessFetchingProducts(products: DataModel)
    func onFailureFetchingProducts(error: Error)
}

class HomeViewModel {
    
    // MARK: - Private Properties
    let productsService: DigioServiceProtocol
    var delegate: HomeViewModelDelegate?
    let sections: [Sections] = [.header, .spotlight, .cash, .products]
    // MARK: - Inits
    
    init(with service: DigioServiceProtocol) {
        self.productsService = service
    }
    
    func fetchData() {
        productsService.fetchData { result in
            switch result {
            
            case .success(let products):
                self.delegate?.onSuccessFetchingProducts(products: products)
            case .failure(let error):
                self.delegate?.onFailureFetchingProducts(error: error)
            }
        }
    }
}
