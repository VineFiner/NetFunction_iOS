//
//  Parsable.swift
//  VNNetWorking
//
//  Created by vine on 2019/2/27.
//  Copyright © 2019 vine. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

protocol Parsable {
    // ps: Result类型下边会声明，这里姑且可以认为函数返回了`Self`
    static func parse(data: Data) -> Result<Self>
}

// 添加默认实现
extension Parsable where Self: Decodable {
    static func parse(data: Data) -> Result<Self> {
        do {
            let model = try JSONDecoder().decode(self, from: data)
            return .success(model)
        } catch let error {
            return .failure(error)
        }
    }
}

// 当Array里的元素遵循Parsable以及Decodable时，Array也遵循Parsable协议
extension Array: Parsable where Array.Element: (Parsable & Decodable) {
    
}

// 添加默认实现
//extension Parsable where Self: SwiftProtobuf.Message {
//    static func parse(data: Data) -> Result<Self> {
//        do {
//            let model = try self.init(serializedData: data)
//            return .success(model)
//        } catch let error {
//            return .failure(error)
//        }
//    }
//}

