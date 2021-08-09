//
//  NowPlaying.swift
//  MovieAPP
//
//  Created by Ulises Gonzalez on 07/08/21.
//

struct NowPlaying: Codable {
    let dates: Dates?
    let page: Int?
    let results: [Result]?
    let totalPages, totalResults: Int?
    enum CodingKeys: String, CodingKey {
        case dates
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Dates: Codable {
    let maximum, minimum: String?
}
