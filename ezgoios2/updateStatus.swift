//
//  updateStatus.swift
//  Unity-iPhone
//
//  Created by vickyliao on 2018/9/27.
//

import Foundation
enum ConnectionResult4{
    case success(Data)
    case failure(Error)
}

func updateStatus(status:String, animal:String, completion: @escaping(ConnectionResult4) -> ()){
    let parameters = ["status":status,"whichAnimal":animal]
    guard let url = URL(string:"http://ezgo.twjoin.com/status")else{return}
    var request = URLRequest(url:url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [.prettyPrinted])else{return}
    request.httpBody = httpBody
    
    let session = URLSession.shared
    print(animal,status)
    session.dataTask(with: request){(data,response,error) in
        if let response = response{
            print(response)
        }
        if let data = data{
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
                print(json!)
                //print("success update")
            }catch{
                print(error)
            }
        }
        }.resume()
}

