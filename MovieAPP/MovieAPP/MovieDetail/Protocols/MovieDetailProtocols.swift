//
//  MovieDetailProtocols.swift
//  MovieAPP
//
//  Created by Ulises Gonzalez on 07/08/21.
//

import UIKit
protocol MovieDetailViewProtocol: AnyObject {
    // Presenter -> View
    func onSuccesMovieData(data: MovieDetail)
    func onErrorMovieData()
}

protocol MovieDetailPresenterProtocol: AnyObject {
    // View -> Presenter
    var interactor: MovieDetailInteractorProtocol? {get set}
    var view: MovieDetailViewProtocol? {get set}
    var router: MovieDetailRouterProtocol? {get set}
    func getMovieData(id: Int)
    func closeView()
}

protocol MovieDetailInteractorProtocol: AnyObject {
    var presenter: MovieDetailOutputInteractorProtocol? {get set}
    // Presenter -> Interactor
    func fetchMovieData(id: Int)
}

protocol MovieDetailOutputInteractorProtocol: AnyObject {
    // Interactor -> PresenterOutput
    func succesMovieData(data: MovieDetail)
    func errorMovieData()
}

protocol MovieDetailRouterProtocol: AnyObject {
    //Presenter -> Wireframe
    static func createModule(id: Int, navigationController: UINavigationController) -> UIViewController
    func dismissScreen()
}
