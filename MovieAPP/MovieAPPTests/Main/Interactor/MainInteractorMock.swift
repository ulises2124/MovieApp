//
//  MainInteractorMock.swift
//  MovieAPPTests
//
//  Created by Ulises Gonzalez on 08/08/21.
//

import XCTest
@testable import MovieBOX
class MainInteractorMock: MainInteractorProtocol {
    weak var presenter: MainOutputInteractorProtocol?
    var expectationForGetList: XCTestExpectation?
    var expectationForGetCollection: XCTestExpectation?
    
    func getList(page: Int) {
        expectationForGetList?.fulfill()
    }
    
    func getCollection() {
        expectationForGetCollection?.fulfill()
    }
}
