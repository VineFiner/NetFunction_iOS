//
//  VNRequestProtocol.swift
//  VNNetWorking
//
//  Created by vine on 2019/2/27.
//  Copyright © 2019 vine. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
protocol Request {
    
    typealias HTTPHeaders = [String: String]
    
    var url: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: HTTPHeaders? { get }
    var httpBody: Data? { get }
    
    /// 请求返回类型（需遵循Parsable协议）
    // 这是 protocol 泛型, 关联类型
    associatedtype ResponseResult: Parsable
}

// 添加一个通用请求体

struct NormalRequest<T: Parsable>: Request {
    var url: String
    var method: HTTPMethod
    var parameters: [String: Any]?
    var headers: HTTPHeaders?
    var httpBody: Data?
    /// 这里重命名泛型 T
    typealias ResponseResult = T
    
    init(_ responseType: ResponseResult.Type,
         urlString: String,
         method: HTTPMethod = .get,
         parameters: [String: Any]? = nil,
         headers: HTTPHeaders? = nil,
         httpBody: Data? = nil) {
        self.url = urlString
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.httpBody = httpBody
    }
}
