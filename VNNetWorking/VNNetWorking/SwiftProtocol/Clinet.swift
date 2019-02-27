//
//  Clinet.swift
//  VNNetWorking
//
//  Created by vine on 2019/2/27.
//  Copyright © 2019 vine. All rights reserved.
//

import Foundation

typealias Handler<T> = (Result<T>) -> ()

protocol Client {
    // 接受一个遵循Parsable的T，最后回调闭包的参数是T里边的Response 也就是Request协议定义的Response
    func send<T: Request>(request: T, completionHandler: @escaping Handler<T.ResponseResult>)
}

struct URLSessionClient: Client {
    static let shared = URLSessionClient()
    private init() {}
    
    func send<T: Request>(request: T, completionHandler: @escaping (Result<T.ResponseResult>) -> ()) {
        var urlString = request.url
        if let param = request.parameters {
            var i = 0
            param.forEach {
                urlString += i == 0 ? "?\($0.key)=\($0.value)" : "&\($0.key)=\($0.value)"
                i += 1
            }
        }
        guard let url = URL(string: urlString) else {
            return
        }
        var req = URLRequest(url: url)
        req.httpMethod = request.method.rawValue
        req.httpBody = request.httpBody
        req.allHTTPHeaderFields = request.headers
        
        URLSession.shared.dataTask(with: req) { (data, respose, error) in
            if let data = data {
                // 使用parse方法反序列化
                let result = T.ResponseResult.parse(data: data)
                switch result {
                case .success(let model):
                    completionHandler(.success(model))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            } else {
                completionHandler(.failure(error!))
            }
        }
    }
}


struct NetworkClient: Client {
    static let shared = NetworkClient()
    
    func send<T: Request>(request: T, completionHandler: @escaping Handler<T.ResponseResult>) {
        var urlString = request.url
        if let param = request.parameters {
            var i = 0
            param.forEach {
                urlString += i == 0 ? "?\($0.key)=\($0.value)" : "&\($0.key)=\($0.value)"
                i += 1
            }
        }
        guard let url = URL(string: urlString) else {
            return
        }
        VNUrlSession.default().accessServer(withURLStr: url.absoluteString) { (data, error) in
            guard let jsonData = data else {
//                completionHandler(.failure(error))
                return
            }
            // 使用parse(:)方法反序列化
            let parseResult = T.ResponseResult.parse(data: jsonData)
            switch parseResult {
            case .success(let model):
                completionHandler(.success(model))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    private init() {}
}
