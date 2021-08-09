//
//  ConnectionManager.swift
//  MovieAPP
//
//  Created by Daniel Mondragón on 07/08/21.
//

import Foundation
public protocol ProtocolNewtworkManager {
    func dispatch(request: RequestType, onSuccess: @escaping (Data, Int) -> Void, onError: @escaping (Error, String) -> Void)
}

public struct ConnectionManager: ProtocolNewtworkManager {
    public static let instance = ConnectionManager()
    
    private init() {}
    
    public func dispatch(request: RequestType, onSuccess: @escaping (Data, Int) -> Void, onError: @escaping (Error, String) -> Void) {
        if !Reachability.isConnectedToNetwork() {
            onError(ErrorManager.noInternet, "TITLE_NO_INTERNET")
        } else {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 50.0
            configuration.timeoutIntervalForResource = 50.0
            let session = URLSession(configuration: configuration)
            guard let url = URL(string: request.url!) else {
                onError(ErrorManager.errorInvalidUrl, "url incorrecta")
                return
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.method.rawValue
            
            if request.params != nil {
                guard let params = request.params else {
                    onError(ErrorManager.errorNoParameters, "no hay parametros")
                    return
                }
                guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                    onError(ErrorManager.errorSereliziation, "json no serializado")
                    return
                }
                urlRequest.httpBody = httpBody
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            if let headers = request.headers { urlRequest.allHTTPHeaderFields = headers}
            print("Request params \(String(describing: request.params))")
            let task = session.dataTask(with: urlRequest) { (data, response, error) in
                guard let dataResponse = data,
                      error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
                }
                let message = String(decoding: dataResponse, as: UTF8.self)
                if let httpResponse = response as? HTTPURLResponse{
                    if httpResponse.statusCode == 400 || httpResponse.statusCode == 500{
                        print(httpResponse);
                        onError(ErrorManager.errorServicio,message)
                        return
                    }
                    
                    else {
                        onSuccess(dataResponse, httpResponse.statusCode)
                    }
                }
            }
            task.resume()
        }
    }
}
