//
//  MovieDetailRouterTest.swift
//  MovieAPPUITests
//
//  Created by Ulises Gonzalez on 08/08/21.
//

import XCTest
@testable import MovieBOX
class MovieDetailRouterTest: XCTestCase {
    let id = 1
    var router: MovieDetailRouter!
    
    override func setUp() {
        super.setUp()
        let navigationController = UINavigationController()
        let view = MovieDetailView()
        router = MovieDetailRouter(navigationController: navigationController, view: view)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreateModule() {
        let navigationController = UINavigationController()
        let movieDetailViewController = MovieDetailRouter.createModule(id: id, navigationController: navigationController)
        XCTAssertTrue(movieDetailViewController is MovieDetailView)
    }
    
    func testFinish() {
        XCTAssertNotNil(router.dismissScreen())
    }
}
