//
//  I_WarnerMediaTests.swift
//  I-WarnerMediaTests
//
//  Created by Kobi Cook on 7/28/21.
//

import XCTest
@testable import I_WarnerMedia

class I_WarnerMediaTests: XCTestCase {
    
    var viewModel: ViewModel!

    override func setUpWithError() throws {
       viewModel = ViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testProductService() throws {
       
        let promise = expectation(description: "product service...")
        var products = [Product]()
        
        ServiceManager.shared.get { result in
            switch result {
            case .failure:
                promise.assertForOverFulfill = true
            case .success(let prods):
                products = prods
                promise.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(!products.isEmpty)
        
    }
}
