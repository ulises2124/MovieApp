//
//  MainPresenter.swift
//  MovieAPP
//
//  Created by Ulises Gonzalez on 07/08/21.
//

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var interactor: MainInteractorProtocol?
    var presenter: MainPresenterProtocol?
    var router: MainRouterProtocol?
    
    func fetchData(page: Int) {
        self.interactor?.getList(page: page)
    }
    
    func fetchCollectionData() {
        self.interactor?.getCollection()
    }
    
    func openDetail(id: Int) {
        router?.pushToDetail(id: id)
    }
}

extension MainPresenter: MainOutputInteractorProtocol {
    func onSuccessFetchCollection(list: [Result]) {
        self.view?.onSuccessFetchCollection(list: list)
    }
    
    func onSuccessFetchList(list: [Result]) {
        self.view?.onSuccessFetchList(list: list)
    }
}
