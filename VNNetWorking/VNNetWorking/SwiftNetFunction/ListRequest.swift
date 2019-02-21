//
//  ListRequest.swift
//  VNNetWorking
//
//  Created by vine on 2019/2/15.
//  Copyright © 2019 vine. All rights reserved.
//

import Foundation

enum GetResourcesReques<ResourceType> {
    case success(ResourceType)
    case failure
}
struct ListRequest {
    var resource: String
    
    init(resourcePath: String) {
        let sourceString = "https://api.iclient.ifeng.com/\(resourcePath)?id=SYLB10,SYDT10,SYRECOMMEND&gv=4.5.1&av=4.5.1&uid=865665020505370&deviceid=865665020505370&proid=ifengnews"
        resource = sourceString
    }
    
    func update(with page: Int, completion: @escaping (GetResourcesReques<Data>) -> Void) {
        let url = resource.appending("&page=\(page)")
        VNUrlSession.default().accessServer(withURLStr: url) { (data, error) in
            guard let jsonData = data else {
                completion(.failure)
                return
            }
            completion(.success(jsonData))
        }
    }
}
