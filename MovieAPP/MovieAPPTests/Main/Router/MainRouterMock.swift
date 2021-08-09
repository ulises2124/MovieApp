//
//  MainRouterMock.swift
//  MovieAPPTests
//
//  Created by Ulises Gonzalez on 08/08/21.
//

import XCTest
@testable import MovieBOX
class MainRouterMock: MainRouterProtocol {
    var navigationController = UINavigationController()
    var expectationForPushToDetail: XCTestExpectation?
    
    static func createModule(navigationController: UINavigationController) -> UIViewController {
        return UIViewController()
    }
    
    func pushToDetail(id: Int) {
        expectationForPushToDetail?.fulfill()
    }
}
