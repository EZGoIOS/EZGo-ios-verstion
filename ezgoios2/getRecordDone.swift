//
//  getRecordDone.swift
//  ezgo1
//
//  Created by Administrator on 2018/5/5.
//  Copyright © 2018年 vickyliao. All rights reserved.
//

import Foundation

public var rec_done = NSHomeDirectory() + "/Documents/rec_done.txt"
public var val=String()
func getRecordDone(){
    val = String()
    rec_done = NSHomeDirectory() + "/Documents/rec_done.txt"
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
                val = String(describing: ((json!.value(forKey: "result")!) as! NSObject).value(forKey: "record_done")!).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\r\n", with: "")
                try val.write(toFile: rec_done, atomically: true, encoding: .utf8)
                print(rec_done)
                //var rec_done=[String](repeating:"0", count:18)
                //rec_done = val.components(separatedBy: ",")
                //print(rec_done)
                //self.label.text = json[0]["record_done"]
            }catch{
                print(error)
            }
        }
        }.resume()
    
}
