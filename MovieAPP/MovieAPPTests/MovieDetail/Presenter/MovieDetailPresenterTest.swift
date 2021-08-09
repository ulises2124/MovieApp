//
//  MovieDetailPresenterTest.swift
//  MovieAPPUITests
//
//  Created by Ulises Gonzalez on 08/08/21.
//

import XCTest
@testable import MovieBOX
class MovieDetailPresenterTest: XCTestCase {
    var interactor: MovieDetailInteractorMock!
    var presenter: MovieDetailPresenter!
    var router: MovieDetailRouterMock!
    var view: MovieDetailViewMock!
    
    override func setUp() {
        super.setUp()
        presenter = MovieDetailPresenter()
        interactor = MovieDetailInteractorMock()
        router = MovieDetailRouterMock()
        view = MovieDetailViewMock()
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFinish() {
        let expectationFordDismissScreen = expectation(description: "testFinish")
        router.expectationFordDismissScreen = expectationFordDismissScreen
        presenter.closeView()
        wait(for: [expectationFordDismissScreen], timeout: 5)
    }
    
    func testFetchData() {
        let expectationForFetchMovieData = expectation(description: "testFetchData")
        interactor.expectationForFetchMovieData = expectationForFetchMovieData
        presenter.getMovieData(id: 1)
        wait(for: [expectationForFetchMovieData], timeout: 5)
    }
}
