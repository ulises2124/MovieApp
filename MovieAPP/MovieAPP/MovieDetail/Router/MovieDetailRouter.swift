//
//  MovieDetailRouter.swift
//  MovieAPP
//
//  Created by Daniel Mondragón on 07/08/21.
//

import UIKit
class MovieDetailRouter: MovieDetailRouterProtocol {
    var navigationController: UINavigationController
    weak var view: MovieDetailView?
    init(navigationController: UINavigationController, view: MovieDetailView) {
        self.navigationController = navigationController
        self.view = view
    }
    
    static func createModule(id: Int, navigationController: UINavigationController) -> UIViewController {
        let view = MovieDetailView()
        let router: MovieDetailRouterProtocol = MovieDetailRouter(navigationController: navigationController, view: view)
        let presenter: MovieDetailPresenterProtocol & MovieDetailOutputInteractorProtocol = MovieDetailPresenter()
        let interactor: MovieDetailInteractorProtocol = MovieDetailInteractor()
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        view.presenter = presenter
        view.id = id
        return view
    }
    
    func dismissScreen() {
        self.view?.dismiss(animated: true, completion: nil)
    }
}
