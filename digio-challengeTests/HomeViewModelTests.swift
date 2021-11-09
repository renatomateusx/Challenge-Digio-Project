//
//  HomeViewControllerUITest.swift
//  HomeViewControllerUITest
//
//  Created by Renato Mateus on 08/11/21.
//

import XCTest
@testable import digio_challenge

class HomeViewModelTests: XCTestCase {

    typealias Completion<T> = ((_ value: T) -> Void)
    var viewModel: HomeViewModel!
    var successCompletion: Completion<Any>!
    var failureCompletion: Completion<Any>!
    lazy var serviceMockSuccess: DigioServiceMockSuccess = DigioServiceMockSuccess()
    lazy var serviceMockFailure: DigioServiceMockFailure = DigioServiceMockFailure()
    
    override func tearDown() {
        viewModel = nil
        
        super.tearDown()
    }
    
    func testFetchIfSuccess() {
        viewModel = HomeViewModel(with: serviceMockSuccess)
        viewModel?.delegate = self
        let expectation = XCTestExpectation.init(description: "Digio Data")
        self.successCompletion = { posts in
            XCTAssertNotNil(posts, "No data was downloaded.")
            expectation.fulfill()
        }
        viewModel.fetchData()
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testFetchPostsIfFailure() {
        viewModel = HomeViewModel(with: serviceMockFailure)
        viewModel.delegate = self
        let expectation = XCTestExpectation.init(description: "Error")
        self.failureCompletion = { error in
            XCTAssertNotNil(error, "No data was downloaded.")
            expectation.fulfill()
        }
        viewModel.fetchData()
        wait(for: [expectation], timeout: 60.0)
    }
}

extension HomeViewModelTests: HomeViewModelDelegate {
    func onSuccessFetchingProducts(products: DataModel) {
        successCompletion(products)
    }
    
    func onFailureFetchingProducts(error: Error) {
        failureCompletion(error)
    }
}
