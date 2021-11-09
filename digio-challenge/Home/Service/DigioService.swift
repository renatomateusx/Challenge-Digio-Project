//
//  ProductsService.swift
//  digio-challenge
//
//  Created by Renato Mateus on 08/11/21.
//

import Foundation
protocol DigioServiceProtocol: AnyObject {
    func fetchData(completion: @escaping(Result<DataModel, Error>) -> Void)
}

class DigioService {
    private var service: NetworkService
    
    init(service: NetworkService = NetworkService()) {
        self.service = service
    }
}

extension DigioService: DigioServiceProtocol {
    func fetchData(completion: @escaping(Result<DataModel, Error>) -> Void) {
        let url = URL(string: Constants.productsURL)!
        _ = service.request(for: url, completion: completion)
    }
}
