//
//  MainProtocols.swift
//  MovieAPP
//
//  Created by Daniel Mondragón on 07/08/21.
//
import UIKit
protocol MainViewProtocol: AnyObject {
    // Presenter -> View
    func onSuccessFetchList(list: [Result])
    func onSuccessFetchCollection(list: [Result])
}

protocol MainPresenterProtocol: AnyObject {
    // View -> Presenter
    var interactor: MainInteractorProtocol? {get set}
    var view: MainViewProtocol? {get set}
    var router: MainRouterProtocol? {get set}
    func fetchData(page: Int)
    func fetchCollectionData()
    func openDetail(id: Int)
}

protocol MainInteractorProtocol: AnyObject {
    var presenter: MainOutputInteractorProtocol? {get set}
    // Presenter -> Interactor
    func getList(page: Int)
    func getCollection()
}

protocol MainOutputInteractorProtocol: AnyObject {
    // Interactor -> PresenterOutput
    func onSuccessFetchList(list: [Result])
    func onSuccessFetchCollection(list: [Result])
}

protocol MainRouterProtocol: AnyObject {
    //Presenter -> Wireframe
    static func createModule(navigationController: UINavigationController) -> UIViewController
    func pushToDetail(id: Int)
}
