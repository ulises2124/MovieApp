//
//  ResponseDispatcher.swift
//  MovieAPP
//
//  Created by Daniel Mondragón on 07/08/21.
//


import Foundation
public protocol ResponseDispatcher {
    associatedtype ResponseType: Codable
    var data: RequestType { get }
    var parameters: [String: Any]? { get }
    var urlOptional: String? { get }
}

public extension ResponseDispatcher {
    func execute (
        disparador: ProtocolNewtworkManager = ConnectionManager.instance,
        onSuccess: @escaping (ResponseType, Int) -> Void,
        onError: @escaping (Error, String) -> Void
    ) {
        
        disparador.dispatch(
            request: self.data,
            onSuccess: { (responseData: Data, codeHttp: Int) in
                do {
                    
                    let jsonDecoder = JSONDecoder()
                    let result = try jsonDecoder.decode(ResponseType.self, from: responseData)
                    DispatchQueue.main.async {
                        onSuccess(result, codeHttp)
                    }
                    
                } catch let error {
                    DispatchQueue.main.async {
                        print("Error en Response Dispatcher \(error)")
                        onError(ErrorManager.errorServicio, "Error al parsear datos")
                        return
                    }
                }
            },
            onError: { (error: Error, message: String) in
                DispatchQueue.main.async {
                    onError(ErrorManager.errorServicio, "Error al parsear datos")
                }
            }
        )
    }
}
