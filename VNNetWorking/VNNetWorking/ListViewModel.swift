//
//  ListViewModel.swift
//  VNNetWorking
//
//  Created by vine on 2019/2/27.
//  Copyright © 2019 vine. All rights reserved.
//

import Foundation
struct ListViewModel {
    func getBaiduInfo() {
        // 1.准备请求体
        let urlString = "https://www.baidu.com/user"
        guard let url = URL(string: urlString) else {
            return
        }
        let headers = ["token": "thisisatesttokenvalue"]
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        
        // 2.使用URLSeesion创建网络任务
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                // 3.将数据反序列化
                let user = try? JSONDecoder().decode(User.self, from: data)
                print(user?.name ?? "")
            }
            }.resume()
    }
    
    func getUserInfoData() {
        let userRequest = BaiduRequest(User.self, path: .user)
        NetworkClient.shared.send(request: userRequest) { (result) in
            switch result {
            case .success(let manager):
                // 此时拿到的已经是Manager实例了
                print("manager: \(manager)")
            case .failure(let error):
                print("get manager failure: \(error)")
            }
        }
    }
    func getManagerInfo() {
        let managerRequest = BaiduRequest(Manager.self, path: .manager, method: .post)
        
        NetworkClient.shared.send(request: managerRequest) { result in
            switch result {
            case .success(let manager):
                // 此时拿到的已经是Manager实例了
                print("manager: \(manager)")
            case .failure(let error):
                print("get manager failure: \(error)")
            }
        }
    }
}
