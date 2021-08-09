//
//  MainViewMock.swift
//  MovieAPPTests
//
//  Created by Ulises Gonzalez on 08/08/21.
//

import XCTest
@testable import MovieBOX
class MainViewMock:
    MainViewProtocol {
    var expectationForOnSuccessFetchList: XCTestExpectation?
    var expectationForOnSuccessFetchCollection: XCTestExpectation?
    var expectationForOnErrorFetchList: XCTestExpectation?
    
    func onSuccessFetchList(list: [Result]) {
        expectationForOnErrorFetchList?.fulfill()
    }
    
    func onSuccessFetchCollection(list: [Result]) {
        expectationForOnSuccessFetchCollection?.fulfill()
    }
}
