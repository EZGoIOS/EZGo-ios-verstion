//
//  getUserDetail.swift
//  ezgo1
//
//  Created by vickyliao on 2018/3/9.
//  Copyright © 2018年 vickyliao. All rights reserved.
//

import Foundation

var uuid=""

public var filePath=""
//public var defaults = UserDefaults.standard
//public var name = defaults.string(forKey: "device id")
func getWorksheet(){
    let defaults = UserDefaults.standard
    let name = defaults.string(forKey: "device id")
    let parameters = ["device_id" : name]
    guard let url = URL(string:"http://ezgo.twjoin.com/update")else{return}
    var request = URLRequest(url:url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])else{return}
    request.httpBody = httpBody
    
    let session = URLSession.shared
    
    session.dataTask(with:request){(data,response,error) in
        if let response = response{
            print(response)
        }
        if let data = data{
            do{
                let json = try JSONSerialization.jsonObject(with: data, options:[.allowFragments]) as? NSDictionary
                //print(json)
                print(json!)
                let val = (((json!.value(forKey: "userID")!)) as AnyObject).value(forKey: "user_id")!
                print(String(describing: val))
                UserDefaults.standard.set(String(describing: val), forKey: "user_id")
                let userid = UserDefaults.standard.string(forKey: "user_id")
                print(String(describing: userid))
                //self.label.text = json[0]["record_done"]
            }catch{
                print(error)
            }
        }
        }.resume()
    
}
