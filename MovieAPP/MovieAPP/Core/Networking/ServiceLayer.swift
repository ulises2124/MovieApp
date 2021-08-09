//
//  ServiceLayer.swift
//  MovieAPP
//
//  Created by Daniel Mondragón on 07/08/21.
//


import Foundation
// MARK:- Collection Caller
struct CallMoviesCollection: ResponseDispatcher {
    typealias ResponseType = NowPlaying
    var parameters: [String : Any]?
    var urlOptional: String?
    var path: String
    var data: RequestType {
        return RequestType.init(path: path, method: .get, params: nil, headers: nil, url: Endpoint.mainUrl)
    }
    init(section: String, language: String, page: String, apiKey: String) {
        self.path = "\(section)?language=\(language)&page=\(page)&api_key=\(apiKey)"
    }
}

// MARK:- List Callers
struct CallMoviesList: ResponseDispatcher {
    typealias ResponseType = Popular
    var parameters: [String : Any]?
    var urlOptional: String?
    var path: String
    var data: RequestType {
        return RequestType.init(path: path, method: .get, params: nil, headers: nil, url: Endpoint.mainUrl)
    }
    init(section: String, language: String, page: String, apiKey: String) {
        self.path = "\(section)?api_key=\(apiKey)&language=\(language)&page=\(page)"
    }
}

// MARK:- Detail Callers
struct CallDetail: ResponseDispatcher {
    typealias ResponseType = MovieDetail
    var parameters: [String : Any]?
    var urlOptional: String?
    var path: String
    var data: RequestType {
        return RequestType.init(path: path, method: .get, params: nil, url: Endpoint.mainUrl)
    }
    init(id: Int, apiKey: String, language: String) {
        self.path = "\(id)?api_key=\(apiKey)&language=\(language)"
    }
}
