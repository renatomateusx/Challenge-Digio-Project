//
//  DigioServiceMockFailure.swift
//  digio-challengeTests
//
//  Created by Renato Mateus on 09/11/21.
//

import Foundation
@testable import digio_challenge

class DigioServiceMockFailure: DigioServiceProtocol {
    func fetchData(completion: @escaping (Result<DataModel, Error>) -> Void) {
        completion(.failure(NSError(domain: "No data was downloaded.",
                                    code: 400,
                                    userInfo: nil)))
    }
}
