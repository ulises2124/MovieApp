//
//  MovieDetailInteractorMock.swift
//  MovieAPPUITests
//
//  Created by Daniel Mondragón on 08/08/21.
//

import XCTest
@testable import MovieBOX
class MovieDetailInteractorMock: MovieDetailInteractorProtocol {
    weak var presenter: MovieDetailOutputInteractorProtocol?
    var expectationForFetchMovieData: XCTestExpectation?
    
    func fetchMovieData(id: Int) {
        expectationForFetchMovieData?.fulfill()
    }
}
