//
//  MovieDetailViewMock.swift
//  MovieAPPUITests
//
//  Created by Daniel Mondragón on 08/08/21.
//

import XCTest
@testable import MovieBOX
class MovieDetailViewMock:
    MovieDetailViewProtocol {
    var expectationForOnSuccesMovieData: XCTestExpectation?
    var expectationForOnErrorMovieData: XCTestExpectation?
    
    func onSuccesMovieData(data: MovieDetail) {
        expectationForOnSuccesMovieData?.fulfill()
    }
    
    func onErrorMovieData() {
        expectationForOnErrorMovieData?.fulfill()
    }
}
