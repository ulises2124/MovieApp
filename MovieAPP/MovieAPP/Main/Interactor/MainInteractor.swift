//
//  MainInteractor.swift
//  MovieAPP
//
//  Created by Ulises Gonzalez on 07/08/21.
//
import UIKit
class  MainInteractor: MainInteractorProtocol {
    weak var presenter: MainOutputInteractorProtocol?
    func getList(page: Int) {
        CallMoviesList(section: "popular", language: "en_US", page: "\(page)", apiKey: Keys.apiKey).execute { result, code in
            print("RESPONSE==========>", result)
            print("CODE==========>", code)
            if code == 200 {
                if let list = result.results {
                    self.presenter?.onSuccessFetchList(list: list)
                }
            }
        } onError: { error, msg in
            print("Error==========> \(error) \(msg)")
        }
    }
    
    func getCollection() {
        CallMoviesCollection(section: "now_playing", language: "en-US", page: "undefined", apiKey: Keys.apiKey).execute { result, code in
            print("RESPONSE==========>", result)
            print("CODE==========>", code)
            if code == 200 {
                if let list = result.results {
                    self.presenter?.onSuccessFetchCollection(list: list)
                }
            }
        } onError: { error, msg in
            print("Error==========> \(error) \(msg)")
        }
    }
}
