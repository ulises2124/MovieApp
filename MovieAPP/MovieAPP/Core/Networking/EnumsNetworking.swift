//
//  EnumsNetworking.swift
//  MovieAPP
//
//  Created by Ulises Gonzalez on 07/08/21.
//


import Foundation

public enum ErrorManager: Swift.Error {
    case errorInvalidUrl
    case errorNoParameters
    case errorHeaders
    case errorSereliziation
    case errorServicio
    case noInternet
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
