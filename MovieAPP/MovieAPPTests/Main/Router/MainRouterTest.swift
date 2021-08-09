//
//  MainRouterTest.swift
//  MovieAPPTests
//
//  Created by Daniel Mondragón on 08/08/21.
//

import XCTest
@testable import MovieBOX
class MainRouterTest: XCTestCase {
    var router: MainRouter!
    
    override func setUp() {
        super.setUp()
        let navigationController = UINavigationController()
        router = MainRouter(navigationController: navigationController)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreateModule() {
        let navigationController = UINavigationController()
        let movieDetailViewController = MainRouter.createModule(navigationController: navigationController)
        XCTAssertTrue(movieDetailViewController is MainView)
    }
    
    func testPushDetail() {
        XCTAssertNotNil(router.pushToDetail(id: 1))
    }
}
