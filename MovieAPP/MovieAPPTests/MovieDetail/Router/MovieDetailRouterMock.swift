//
//  MovieDetailRouterMock.swift
//  MovieAPPUITests
//
//  Created by Ulises Gonzalez on 08/08/21.
//

import XCTest
@testable import MovieBOX
class MovieDetailRouterMock: MovieDetailRouterProtocol {
    var navigationController = UINavigationController()
    var expectationFordDismissScreen: XCTestExpectation?
    
    static func createModule(id: Int, navigationController: UINavigationController) -> UIViewController {
        return UIViewController()
    }
    
    func dismissScreen() {
        expectationFordDismissScreen?.fulfill()
    }
}
