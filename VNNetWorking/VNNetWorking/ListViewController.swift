//
//  ListViewController.swift
//  VNNetWorking
//
//  Created by vine on 2019/2/21.
//  Copyright © 2019 vine. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnClick(_ sender: UIButton) {
        getJsonData(with: 1)
    }
    
    func getJsonData(with page: Int) {
        let listRequest = ListRequest(resourcePath: "ClientNews")
        listRequest.update(with: page) { (result) in
            switch result {
            case .success(let json):
                if let array = try? JSONSerialization.jsonObject(with: json, options: .allowFragments) {
                    print("This is json:\(array)")
                }
            case .failure:
                print("This is error")
            }
        }
    }
    
    func userInfo() {
        let list = ListViewModel()
        list.getBaiduInfo()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
