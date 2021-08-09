//
//  MainPresenterTest.swift
//  MovieAPPTests
//
//  Created by Ulises Gonzalez on 08/08/21.
//

import XCTest
@testable import MovieBOX
class MainPresenterTest: XCTestCase {
    var interactor: MainInteractorMock!
    var presenter: MainPresenter!
    var router: MainRouterMock!
    var view: MainViewMock!
    
    override func setUp() {
        super.setUp()
        presenter = MainPresenter()
        interactor = MainInteractorMock()
        router = MainRouterMock()
        view = MainViewMock()
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchListData() {
        let expectationForGetList = expectation(description: "testFetchListData")
        interactor.expectationForGetList = expectationForGetList
        presenter.fetchData(page: 1)
        wait(for: [expectationForGetList], timeout: 5)
    }
    
    func testFetchCollectionData() {
        let expectationForGetCollection = expectation(description: "testFetchCollectionData")
        interactor.expectationForGetCollection = expectationForGetCollection
        presenter.fetchCollectionData()
        wait(for: [expectationForGetCollection], timeout: 5)
    }

    func testOpenDetail() {
        let expectationForPushToDetail = expectation(description: "testOpenDetail")
        router.expectationForPushToDetail = expectationForPushToDetail
        presenter.openDetail(id: 1)
        wait(for: [expectationForPushToDetail], timeout: 5)
    }
}
