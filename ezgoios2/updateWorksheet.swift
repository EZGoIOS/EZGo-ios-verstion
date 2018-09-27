//
//  updateWorksheet.swift
//  ezgo1
//
//  Created by vickyliao on 2018/5/2.
//  Copyright © 2018年 vickyliao. All rights reserved.
//

import Foundation
enum ConnectionResult2{
    case success(Data)
    case failure(Error)
}

func updateWorksheet(user_id:String, correct:String, question_id:String, completion: @escaping(ConnectionResult2) -> ()){
    var parameters = ["correct":correct,"question_id":question_id]
    guard let url = URL(string:"http://ezgo.twjoin.com/updateAns/" + user_id)else{return}
    var request = URLRequest(url:url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [.prettyPrinted])else{return}
    request.httpBody = httpBody
    
    let session = URLSession.shared
    
    session.dataTask(with: request){(data,response,error) in
        if let response = response{
            print(response)
        }
        if let data = data{
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
                print(json!)
                
            }catch{
                print(error)
            }
        }
        }.resume()
}
