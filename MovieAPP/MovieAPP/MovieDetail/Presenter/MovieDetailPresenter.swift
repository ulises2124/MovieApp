//
//  MovieDetailPresenter.swift
//  MovieAPP
//
//  Created by Daniel Mondragón on 07/08/21.
//
import UIKit
class MovieDetailPresenter: MovieDetailPresenterProtocol {
    weak var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorProtocol?
    var presenter: MovieDetailPresenterProtocol?
    var router: MovieDetailRouterProtocol?
    func getMovieData(id: Int) {
        self.interactor?.fetchMovieData(id: id)
    }

    func closeView() {
        self.router?.dismissScreen()
    }
}

extension MovieDetailPresenter: MovieDetailOutputInteractorProtocol {
    func succesMovieData(data: MovieDetail) {
        self.view?.onSuccesMovieData(data: data)
    }

    func errorMovieData() {
        self.view?.onErrorMovieData()
    }
}
