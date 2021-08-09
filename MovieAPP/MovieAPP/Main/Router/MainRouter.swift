//
//  MainRouter.swift
//  MovieAPP
//
//  Created by Daniel Mondragón on 07/08/21.
//
import UIKit
class MainRouter: MainRouterProtocol {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    static func createModule(navigationController: UINavigationController) -> UIViewController {
        let view = MainView()
        let router: MainRouterProtocol = MainRouter(navigationController: navigationController)
        let presenter: MainPresenterProtocol & MainOutputInteractorProtocol = MainPresenter()
        let interactor: MainInteractorProtocol = MainInteractor()
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    
    func pushToDetail(id: Int) {
        let detail = MovieDetailRouter.createModule(id: id, navigationController: navigationController)
        navigationController.present(detail, animated: true)
    }
}
