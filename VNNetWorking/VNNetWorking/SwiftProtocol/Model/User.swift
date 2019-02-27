//
//  User.swift
//  VNNetWorking
//
//  Created by vine on 2019/2/27.
//  Copyright © 2019 vine. All rights reserved.
//

import Foundation

struct User {
    var name: String
}

extension User: Parsable {
    // 这里遵从解析协议，可自定义解析
}

extension User: Codable {
    // 遵从 Codable 协议， 有默认解析实现
}
