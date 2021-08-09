//
//  MovieDetailInteractor.swift
//  MovieAPP
//
//  Created by Daniel Mondragón on 07/08/21.
//
import UIKit
class MovieDetailInteractor: MovieDetailInteractorProtocol {
    weak var presenter: MovieDetailOutputInteractorProtocol?
    
    func fetchMovieData(id: Int) {
        CallDetail(id: id, apiKey: Keys.apiKey, language: "en-US").execute{ [weak self] result, code in
            print("RESPONSE==========>", result)
            print("CODE==========>", code)
            if code == 200 {
                self?.presenter?.succesMovieData(data: result)
            } else {
                self?.presenter?.errorMovieData()
            }
        } onError: { error, msg in
            print("Error==========> \(error) \(msg)")
        }
    }
}
