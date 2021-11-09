//
//  DigioServiceMock.swift
//  digio-challengeTests
//
//  Created by Renato Mateus on 09/11/21.
//

import Foundation
@testable import digio_challenge

class DigioServiceMockSuccess: DigioServiceProtocol {
    func fetchData(completion: @escaping (Result<DataModel, Error>) -> Void) {
        let fakeDataModel: DataModel = DataModel(spotlight: [],
                                             products: [],
                                             cash: Cash(title: "",
                                                        bannerURL: "",
                                                        description: ""))
        completion(.success(fakeDataModel))
    }
}
