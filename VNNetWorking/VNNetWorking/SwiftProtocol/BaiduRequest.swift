//
//  BaiduRequest.swift
//  VNNetWorking
//
//  Created by vine on 2019/2/27.
//  Copyright © 2019 vine. All rights reserved.
//

import Foundation

private let host = "https://www.baidu.com"

enum BaiduPath: String {
    case user = "/user"
    case manager = "/manager"
    case driver = "/driver"
}

struct BaiduRequest<T: Parsable>: Request {
    var url: String
    var method: HTTPMethod
    var parameters: [String: Any]?
    var headers: HTTPHeaders?
    var httpBody: Data?
    
    typealias ResponseResult = T
    
    init(_ responseType: ResponseResult.Type,
         path: BaiduPath,
         method: HTTPMethod = .get,
         parameters: [String: Any]? = nil,
         headers: HTTPHeaders? = nil,
         httpBody: Data? = nil) {
        self.url = host + path.rawValue
        self.method = method
        self.parameters = parameters
        self.httpBody = httpBody
        self.headers = headers
    }
}
